-- T03.6. Three login codes per email per hour (SI050).
-- The auth-send-email Edge Function calls these as the service role.

create table public.auth_code_requests (
  id bigint generated always as identity primary key,
  email text not null,
  requested_at timestamptz not null default now()
);

create index auth_code_requests_email_requested_idx
  on public.auth_code_requests (lower(email), requested_at desc);

alter table public.auth_code_requests enable row level security;

revoke all on public.auth_code_requests from anon, authenticated;

create or replace function public.reserve_login_code(p_email text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  normalized text;
  n int;
  oldest timestamptz;
  retry_min int;
begin
  normalized := lower(btrim(p_email));
  if normalized is null or normalized = '' or position('@' in normalized) = 0 then
    raise exception using errcode = 'P0001', message = 'SI001';
  end if;

  perform pg_advisory_xact_lock(hashtext(normalized));

  select count(*), min(requested_at)
  into n, oldest
  from public.auth_code_requests
  where lower(email) = normalized
    and requested_at > public.app_now() - interval '1 hour';

  if n >= 3 then
    retry_min := greatest(
      1,
      ceil(extract(epoch from (oldest + interval '1 hour' - public.app_now())) / 60.0)
    )::int;
    return jsonb_build_object(
      'ok', false,
      'code', 'SI050',
      'retry_after_min', retry_min
    );
  end if;

  insert into public.auth_code_requests (email, requested_at)
  values (normalized, public.app_now());

  return jsonb_build_object('ok', true);
end;
$$;

create or replace function public.release_login_code(p_email text)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  normalized text;
begin
  normalized := lower(btrim(p_email));
  delete from public.auth_code_requests
  where id = (
    select id
    from public.auth_code_requests
    where lower(email) = normalized
    order by requested_at desc, id desc
    limit 1
  );
end;
$$;

revoke all on function public.reserve_login_code(text) from public, anon, authenticated;
revoke all on function public.release_login_code(text) from public, anon, authenticated;
grant execute on function public.reserve_login_code(text) to service_role;
grant execute on function public.release_login_code(text) to service_role;
