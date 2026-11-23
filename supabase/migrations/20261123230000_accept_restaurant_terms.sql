-- T04.10. A restaurant accepts terms on first login. Customers cannot call this.

create or replace function public.accept_restaurant_terms()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  caller uuid := auth.uid();
  restaurant_id uuid;
begin
  if caller is null or public.app_role() is distinct from 'restaurant' then
    raise exception using errcode = 'P0001', message = 'SI001';
  end if;

  update public.restaurants
  set
    terms_accepted_at = coalesce(restaurants.terms_accepted_at, public.app_now()),
    updated_at = public.app_now()
  where restaurants.user_id = caller
  returning restaurants.id into restaurant_id;

  if restaurant_id is null then
    raise exception using errcode = 'P0001', message = 'SI001';
  end if;
end;
$$;

revoke all on function public.accept_restaurant_terms() from public;
grant execute on function public.accept_restaurant_terms() to authenticated;
