begin;
select plan(20);

select policies_are(
  'public',
  'profiles',
  array['profiles_select', 'profiles_update_own', 'profiles_admin_update']
);
select policies_are('public', 'areas', array['areas_read']);
select policies_are('public', 'categories', array['categories_read']);
select policies_are('public', 'dietary_tags', array['dietary_tags_read']);
select policies_are(
  'public',
  'restaurants',
  array['restaurants_select', 'restaurants_admin_insert', 'restaurants_admin_update']
);
select policies_are(
  'public',
  'opening_hours',
  array[
    'opening_hours_select',
    'opening_hours_admin_insert',
    'opening_hours_admin_update',
    'opening_hours_admin_delete'
  ]
);
select policies_are('public', 'pickup_windows', array['pickup_windows_select']);
select policies_are(
  'public',
  'listings',
  array['listings_select', 'listings_insert', 'listings_update', 'listings_delete']
);
select policies_are(
  'public',
  'listing_tags',
  array['listing_tags_select', 'listing_tags_write']
);
select policies_are('public', 'orders', array['orders_select']);
select policies_are('public', 'order_items', array['order_items_select']);
select policies_are('public', 'app_settings', array['app_settings_admin_read']);
select policies_are('public', 'device_tokens', array['device_tokens_own']);
select policies_are('public', 'outbox', array['outbox_admin_read']);
select policies_are('public', 'audit_log', array['audit_log_admin_read']);

select ok(
  (
    select b.public
      and b.file_size_limit = 1048576
      and b.allowed_mime_types @> array['image/jpeg', 'image/png', 'image/webp']
    from storage.buckets as b
    where b.id = 'restaurant-logos'
  ),
  'restaurant logos are public, at most 1 MB, and jpeg, png, or webp'
);
select ok(
  (
    select b.public
      and b.file_size_limit = 1048576
      and b.allowed_mime_types @> array['image/jpeg', 'image/webp']
      and not (b.allowed_mime_types @> array['image/png'])
    from storage.buckets as b
    where b.id = 'listing-photos'
  ),
  'listing photos are public, at most 1 MB, and jpeg or webp'
);
select ok(
  exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'listing_photos_restaurant_insert'
  ),
  'a restaurant can upload only under its own photo folder'
);
select ok(
  exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'restaurant_logos_admin_insert'
  ),
  'only an admin can upload a restaurant logo'
);
select ok(
  has_function_privilege('anon', 'public.public_settings()', 'execute'),
  'guests can read the public settings'
);

select * from finish();
rollback;
