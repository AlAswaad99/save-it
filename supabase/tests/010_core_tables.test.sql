begin;
select plan(36);

select enum_has_labels(
  'user_role',
  array['customer', 'restaurant', 'admin'],
  'user_role matches the role list'
);
select enum_has_labels(
  'customer_status',
  array['active', 'warned', 'suspended'],
  'customer_status matches the status list'
);
select enum_has_labels(
  'restaurant_status',
  array['active', 'suspended'],
  'restaurant_status matches the status list'
);
select enum_has_labels(
  'listing_status',
  array['draft', 'live', 'removed'],
  'listing_status matches the status list'
);
select enum_has_labels(
  'order_status',
  array['reserved', 'collected', 'cancelled', 'expired'],
  'order_status matches the status list'
);
select enum_has_labels(
  'cancel_reason',
  array['sold_out', 'closing_early', 'customer_request', 'other'],
  'cancel_reason keeps customer_request for admins'
);
select enum_has_labels('outbox_channel', array['push', 'email'], 'outbox channels');
select enum_has_labels(
  'outbox_state',
  array['pending', 'sent', 'failed'],
  'outbox states'
);

select has_table('public', 'profiles', 'profiles exists');
select has_table('public', 'areas', 'areas exists');
select has_table('public', 'restaurants', 'restaurants exists');
select has_table('public', 'opening_hours', 'opening_hours exists');
select has_table('public', 'categories', 'categories exists');
select has_table('public', 'dietary_tags', 'dietary_tags exists');
select has_table('public', 'app_settings', 'app_settings exists');

select columns_are(
  'public',
  'profiles',
  array[
    'id',
    'role',
    'full_name',
    'email',
    'phone',
    'terms_accepted_at',
    'status',
    'status_changed_at',
    'suspension_lifted_at',
    'is_active',
    'created_at'
  ]
);
select columns_are(
  'public',
  'restaurants',
  array[
    'id',
    'user_id',
    'name',
    'logo_path',
    'address',
    'place_id',
    'location',
    'phone',
    'login_email',
    'area_id',
    'status',
    'terms_accepted_at',
    'created_at',
    'updated_at'
  ]
);
select col_is_fk('public', 'restaurants', 'area_id', 'restaurants.area_id references areas');

select is(
  (select value from public.app_settings where key = 'commission_rate'),
  '0.40'::jsonb,
  'commission_rate is 0.40'
);
select is(
  (select value from public.app_settings where key = 'min_discount'),
  '0.50'::jsonb,
  'min_discount is 0.50'
);
select is(
  (select value from public.app_settings where key = 'currency'),
  '"AED"'::jsonb,
  'currency is AED'
);
select is(
  (select value from public.app_settings where key = 'pickup_earliest'),
  '"16:00"'::jsonb,
  'pickup starts at 16:00'
);
select is(
  (select value from public.app_settings where key = 'pickup_latest'),
  '"23:30"'::jsonb,
  'pickup ends by 23:30'
);
select is(
  (select value from public.app_settings where key = 'max_units_per_listing'),
  '2'::jsonb,
  'max units per listing is 2'
);
select is(
  (select value from public.app_settings where key = 'max_active_orders'),
  '2'::jsonb,
  'max active orders is 2'
);
select is(
  (select value from public.app_settings where key = 'reminder_minutes'),
  '30'::jsonb,
  'reminder is 30 minutes'
);
select is(
  (select value #>> '{}' from public.app_settings where key = 'noshow_warn_count')
    || '/'
    || (select value #>> '{}' from public.app_settings where key = 'noshow_warn_period_days'),
  '2/7',
  'warn at 2 no-shows in 7 days'
);
select is(
  (select value #>> '{}' from public.app_settings where key = 'noshow_suspend_count')
    || '/'
    || (select value #>> '{}' from public.app_settings where key = 'noshow_suspend_period_days'),
  '3/30',
  'suspend at 3 no-shows in 30 days'
);
select is(
  (select value from public.app_settings where key = 'support_email'),
  '"contact@arisehub.org"'::jsonb,
  'support email is contact@arisehub.org'
);
select is(
  (select value from public.app_settings where key = 'prices_include_vat'),
  'true'::jsonb,
  'prices include VAT'
);
select ok(
  not exists (select 1 from public.app_settings where key = 'noshow_period_days'),
  'warning and suspension keep separate windows'
);

select results_eq(
  $$select name from public.categories order by sort$$,
  array[
    'Salads',
    'Savoury Dishes',
    'Sweet Treats',
    'Beverages',
    'Snacks',
    'Bakery',
    'Kids Menu'
  ]::text[],
  'categories match BR-11'
);
select results_eq(
  $$select name from public.dietary_tags order by sort$$,
  array[
    'Vegetarian',
    'Vegan',
    'Gluten-free',
    'Contains nuts',
    'Lactose-free'
  ]::text[],
  'dietary tags match BR-12'
);
select ok(
  not exists (select 1 from public.dietary_tags where name = 'Halal'),
  'Halal is not a tag'
);

select results_eq(
  $$select name from public.areas order by sort$$,
  array[
    'Al Bahyah',
    'Al Bateen',
    'Al Danah',
    'Al Hisn',
    'Al Hudayriyat Island',
    'Al Khalidiya',
    'Al Marina',
    'Al Maryah Island',
    'Al Mina',
    'Al Muneera',
    'Al Mushrif',
    'Al Nahyan',
    'Al Qana',
    'Al Raha',
    'Al Rawdah',
    'Al Reem Island',
    'Al Zahiyah',
    'Al Zeina',
    'Baniyas',
    'Corniche',
    'Khalifa City',
    'Mohamed Bin Zayed City',
    'Mussafah',
    'Rabdan',
    'Saadiyat Island',
    'Yas Island'
  ]::text[],
  'the 26 areas match the decision log spellings'
);
select ok(
  (
    select
      abs(extensions.st_y(location::extensions.geometry) - 24.47604) < 0.000001
      and abs(extensions.st_x(location::extensions.geometry) - 54.32143) < 0.000001
    from public.areas
    where name = 'Al Marina'
  ),
  'Al Marina is the Marina Mall centre'
);

select * from finish();
rollback;
