-- T03.4. Row level security from docs/02-database.md §5 and the storage buckets in §7.
-- Guests and customers reach restaurants, hours, windows, and listings only through RPCs.
-- Those RPCs are added in later weeks.

-- Profiles. Customers may change their name and phone. Admins may change any column.
create or replace function public.protect_profile_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null
    or current_setting('app.trusted_profile_write', true) = 'on'
    or public.is_admin()
  then
    return new;
  end if;

  if public.app_role() = 'customer' and old.id = auth.uid() then
    if new.id is distinct from old.id
      or new.role is distinct from old.role
      or new.email is distinct from old.email
      or new.terms_accepted_at is distinct from old.terms_accepted_at
      or new.status is distinct from old.status
      or new.status_changed_at is distinct from old.status_changed_at
      or new.suspension_lifted_at is distinct from old.suspension_lifted_at
      or new.is_active is distinct from old.is_active
      or new.created_at is distinct from old.created_at
    then
      raise exception using errcode = 'P0001', message = 'SI001';
    end if;
    return new;
  end if;

  raise exception using errcode = 'P0001', message = 'SI001';
end;
$$;

create trigger profiles_protect_columns
  before update on public.profiles
  for each row
  execute function public.protect_profile_columns();

create or replace function public.public_settings()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'currency', public.setting('currency'),
    'max_units_per_listing', public.setting('max_units_per_listing'),
    'max_active_orders', public.setting('max_active_orders'),
    'support_email', public.setting('support_email'),
    'prices_include_vat', public.setting('prices_include_vat'),
    'search_radius_m', public.setting('search_radius_m')
  );
$$;

grant execute on function public.public_settings() to anon, authenticated;

-- Least privilege. RLS then decides which of these rows are visible.
revoke all on
  public.profiles,
  public.areas,
  public.restaurants,
  public.opening_hours,
  public.categories,
  public.dietary_tags,
  public.app_settings,
  public.pickup_windows,
  public.listings,
  public.listing_tags,
  public.orders,
  public.order_items,
  public.device_tokens,
  public.outbox,
  public.audit_log
from anon, authenticated;

grant select on public.areas, public.categories, public.dietary_tags to anon, authenticated;
grant select on
  public.profiles,
  public.restaurants,
  public.opening_hours,
  public.pickup_windows,
  public.listings,
  public.listing_tags,
  public.orders,
  public.order_items,
  public.app_settings,
  public.device_tokens,
  public.outbox,
  public.audit_log
to anon;
grant select, update on public.profiles to authenticated;
grant select on public.restaurants, public.opening_hours, public.pickup_windows to authenticated;
grant select, insert, update, delete on public.restaurants, public.opening_hours to authenticated;
grant select on public.listings, public.orders, public.order_items, public.app_settings to authenticated;
grant select on public.outbox, public.audit_log to authenticated;
grant select, insert, update, delete on public.device_tokens, public.listing_tags to authenticated;
grant select, insert, update, delete on public.listings, public.orders, public.order_items, public.pickup_windows to authenticated;

revoke update on public.listings from authenticated;
grant update (
  name,
  category_id,
  original_price,
  discounted_price,
  quantity,
  photo_path,
  status,
  date,
  copied_from_id
) on public.listings to authenticated;

revoke insert on public.listings from authenticated;
grant insert (
  restaurant_id,
  date,
  name,
  category_id,
  original_price,
  discounted_price,
  quantity,
  photo_path,
  status,
  copied_from_id
) on public.listings to authenticated;

-- profiles
create policy profiles_select on public.profiles
  for select to authenticated
  using (id = auth.uid() or public.is_admin());

create policy profiles_update_own on public.profiles
  for update to authenticated
  using (id = auth.uid() and public.app_role() = 'customer')
  with check (id = auth.uid() and public.app_role() = 'customer');

create policy profiles_admin_update on public.profiles
  for update to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- reference lists are readable by everyone and have no write path
create policy areas_read on public.areas
  for select to anon, authenticated
  using (true);

create policy categories_read on public.categories
  for select to anon, authenticated
  using (true);

create policy dietary_tags_read on public.dietary_tags
  for select to anon, authenticated
  using (true);

-- restaurants
create policy restaurants_select on public.restaurants
  for select to authenticated
  using (user_id = auth.uid() or public.is_admin());

create policy restaurants_admin_insert on public.restaurants
  for insert to authenticated
  with check (public.is_admin());

create policy restaurants_admin_update on public.restaurants
  for update to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- opening hours
create policy opening_hours_select on public.opening_hours
  for select to authenticated
  using (restaurant_id = public.my_restaurant_id() or public.is_admin());

create policy opening_hours_admin_insert on public.opening_hours
  for insert to authenticated
  with check (public.is_admin());

create policy opening_hours_admin_update on public.opening_hours
  for update to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy opening_hours_admin_delete on public.opening_hours
  for delete to authenticated
  using (public.is_admin());

-- pickup windows: restaurants read their own; changes go through set_pickup_window
create policy pickup_windows_select on public.pickup_windows
  for select to authenticated
  using (restaurant_id = public.my_restaurant_id() or public.is_admin());

-- listings
create policy listings_select on public.listings
  for select to authenticated
  using (restaurant_id = public.my_restaurant_id() or public.is_admin());

create policy listings_insert on public.listings
  for insert to authenticated
  with check (restaurant_id = public.my_restaurant_id());

create policy listings_update on public.listings
  for update to authenticated
  using (restaurant_id = public.my_restaurant_id())
  with check (restaurant_id = public.my_restaurant_id());

create policy listings_delete on public.listings
  for delete to authenticated
  using (restaurant_id = public.my_restaurant_id());

create policy listing_tags_select on public.listing_tags
  for select to authenticated
  using (
    public.is_admin()
    or exists (
      select 1
      from public.listings
      where listings.id = listing_tags.listing_id
        and listings.restaurant_id = public.my_restaurant_id()
    )
  );

create policy listing_tags_write on public.listing_tags
  for all to authenticated
  using (
    exists (
      select 1
      from public.listings
      where listings.id = listing_tags.listing_id
        and listings.restaurant_id = public.my_restaurant_id()
    )
  )
  with check (
    exists (
      select 1
      from public.listings
      where listings.id = listing_tags.listing_id
        and listings.restaurant_id = public.my_restaurant_id()
    )
  );

-- orders are changed only by RPCs
create policy orders_select on public.orders
  for select to authenticated
  using (
    customer_id = auth.uid()
    or restaurant_id = public.my_restaurant_id()
    or public.is_admin()
  );

create policy order_items_select on public.order_items
  for select to authenticated
  using (
    exists (
      select 1
      from public.orders
      where orders.id = order_items.order_id
        and (
          orders.customer_id = auth.uid()
          or orders.restaurant_id = public.my_restaurant_id()
          or public.is_admin()
        )
    )
  );

create policy app_settings_admin_read on public.app_settings
  for select to authenticated
  using (public.is_admin());

create policy device_tokens_own on public.device_tokens
  for all to authenticated
  using (
    user_id = auth.uid()
    and public.app_role() in ('customer', 'restaurant')
  )
  with check (
    user_id = auth.uid()
    and public.app_role() in ('customer', 'restaurant')
  );

create policy outbox_admin_read on public.outbox
  for select to authenticated
  using (public.is_admin());

create policy audit_log_admin_read on public.audit_log
  for select to authenticated
  using (public.is_admin());

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values
  (
    'restaurant-logos',
    'restaurant-logos',
    true,
    1048576,
    array['image/jpeg', 'image/png', 'image/webp']
  ),
  (
    'listing-photos',
    'listing-photos',
    true,
    1048576,
    array['image/jpeg', 'image/webp']
  );

create policy restaurant_logos_read on storage.objects
  for select to anon, authenticated
  using (bucket_id = 'restaurant-logos');

create policy listing_photos_read on storage.objects
  for select to anon, authenticated
  using (bucket_id = 'listing-photos');

create policy restaurant_logos_admin_insert on storage.objects
  for insert to authenticated
  with check (bucket_id = 'restaurant-logos' and public.is_admin());

create policy restaurant_logos_admin_update on storage.objects
  for update to authenticated
  using (bucket_id = 'restaurant-logos' and public.is_admin())
  with check (bucket_id = 'restaurant-logos' and public.is_admin());

create policy restaurant_logos_admin_delete on storage.objects
  for delete to authenticated
  using (bucket_id = 'restaurant-logos' and public.is_admin());

create policy listing_photos_restaurant_insert on storage.objects
  for insert to authenticated
  with check (
    bucket_id = 'listing-photos'
    and public.app_role() = 'restaurant'
    and (storage.foldername(name))[1] = public.my_restaurant_id()::text
  );

create policy listing_photos_restaurant_update on storage.objects
  for update to authenticated
  using (
    bucket_id = 'listing-photos'
    and public.app_role() = 'restaurant'
    and (storage.foldername(name))[1] = public.my_restaurant_id()::text
  )
  with check (
    bucket_id = 'listing-photos'
    and public.app_role() = 'restaurant'
    and (storage.foldername(name))[1] = public.my_restaurant_id()::text
  );

create policy listing_photos_restaurant_delete on storage.objects
  for delete to authenticated
  using (
    bucket_id = 'listing-photos'
    and public.app_role() = 'restaurant'
    and (storage.foldername(name))[1] = public.my_restaurant_id()::text
  );
