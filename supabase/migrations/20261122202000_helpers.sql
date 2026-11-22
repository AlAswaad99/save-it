-- T03.3. Helpers from docs/02-database.md §4 and the first-sign-in profile.
-- listing_is_visible and the listing price trigger are Week 5.

create or replace function public.app_now()
returns timestamptz
language sql
stable
set search_path = public
as $$
  select coalesce(
    nullif(current_setting('app.fake_now', true), '')::timestamptz,
    now()
  );
$$;

comment on function public.app_now() is
  'now(), unless a test sets app.fake_now for this transaction.';

create or replace function public.app_today()
returns date
language sql
stable
set search_path = public
as $$
  select (public.app_now() at time zone 'Asia/Dubai')::date;
$$;

comment on function public.app_today() is
  'The business date in Asia/Dubai, based on app_now().';

create or replace function public.setting(p_key text)
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select value
  from public.app_settings
  where key = p_key;
$$;

revoke all on function public.setting(text) from public, anon, authenticated;
grant execute on function public.setting(text) to service_role;

create or replace function public.app_role()
returns public.user_role
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  claims jsonb;
  claim text;
  found_role public.user_role;
begin
  claims := nullif(current_setting('request.jwt.claims', true), '')::jsonb;
  claim := claims ->> 'user_role';
  if claim is null then
    claim := claims -> 'app_metadata' ->> 'user_role';
  end if;
  if claim in ('customer', 'restaurant', 'admin') then
    return claim::public.user_role;
  end if;

  select profiles.role
  into found_role
  from public.profiles
  where profiles.id = auth.uid();

  return found_role;
end;
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    public.app_role() = 'admin'
      and exists (
        select 1
        from public.profiles
        where profiles.id = auth.uid()
          and profiles.role = 'admin'
          and profiles.is_active
      ),
    false
  );
$$;

create or replace function public.my_restaurant_id()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select restaurants.id
  from public.restaurants
  where restaurants.user_id = auth.uid();
$$;

create or replace function public.is_open_now(p_restaurant_id uuid)
returns boolean
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  local_ts timestamp;
  today_dow int;
  yesterday_dow int;
  today_hours public.opening_hours;
  yesterday_hours public.opening_hours;
  local_time time;
begin
  if p_restaurant_id is null then
    return false;
  end if;

  local_ts := public.app_now() at time zone 'Asia/Dubai';
  today_dow := extract(dow from local_ts)::int;
  yesterday_dow := (today_dow + 6) % 7;
  local_time := local_ts::time;

  select *
  into today_hours
  from public.opening_hours
  where opening_hours.restaurant_id = p_restaurant_id
    and opening_hours.weekday = today_dow;

  if found and not today_hours.is_closed then
    if today_hours.closes_at > today_hours.opens_at then
      if local_time >= today_hours.opens_at and local_time < today_hours.closes_at then
        return true;
      end if;
    elsif today_hours.closes_at < today_hours.opens_at then
      if local_time >= today_hours.opens_at then
        return true;
      end if;
    end if;
  end if;

  select *
  into yesterday_hours
  from public.opening_hours
  where opening_hours.restaurant_id = p_restaurant_id
    and opening_hours.weekday = yesterday_dow;

  if found
    and not yesterday_hours.is_closed
    and yesterday_hours.closes_at < yesterday_hours.opens_at
    and local_time < yesterday_hours.closes_at
  then
    return true;
  end if;

  return false;
end;
$$;

comment on function public.is_open_now(uuid) is
  'Today''s opening hours in Asia/Dubai. A close earlier than the open runs past midnight.';

create or replace function public.generate_order_code()
returns text
language plpgsql
volatile
set search_path = public, extensions
as $$
declare
  alphabet constant text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  built text := '';
  i int;
  bytes bytea;
begin
  bytes := extensions.gen_random_bytes(6);
  for i in 0..5 loop
    built := built || substr(alphabet, 1 + (get_byte(bytes, i) % length(alphabet)), 1);
  end loop;
  return built;
end;
$$;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, role, email)
  values (new.id, 'customer', new.email);
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row
  execute function public.handle_new_user();
