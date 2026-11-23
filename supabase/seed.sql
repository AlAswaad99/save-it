-- T03.7. Sample data for the dev project. Run this by hand. It is not loaded by CI.
-- npx supabase db query --remote=oswcdirurugdiespwqcp --yes -f supabase/seed.sql
-- Re-running it updates the same rows. It does not touch restaurants outside this set.
--
-- Dev password for every sample user: SaveIt-dev-1
-- Emails end in @saveit.test so they cannot receive real mail.

insert into public.areas (id, name, location, sort)
select
  seed.id,
  seed.name,
  extensions.st_setsrid(extensions.st_makepoint(seed.lng, seed.lat), 4326)::extensions.geography,
  seed.id
from (
  values
    (1::smallint, 'Al Bahyah'::text, 24.55653::float8, 54.66416::float8),
    (2, 'Al Bateen', 24.45138, 54.33797),
    (3, 'Al Danah', 24.48529, 54.36989),
    (4, 'Al Hisn', 24.48250, 54.35085),
    (5, 'Al Hudayriyat Island', 24.41706, 54.36027),
    (6, 'Al Khalidiya', 24.46934, 54.34881),
    (7, 'Al Marina', 24.47604, 54.32143),
    (8, 'Al Maryah Island', 24.50298, 54.38997),
    (9, 'Al Mina', 24.51828, 54.37594),
    (10, 'Al Muneera', 24.45161, 54.60542),
    (11, 'Al Mushrif', 24.44109, 54.38422),
    (12, 'Al Nahyan', 24.46446, 54.38684),
    (13, 'Al Qana', 24.40400, 54.49189),
    (14, 'Al Raha', 24.44785, 54.59630),
    (15, 'Al Rawdah', 24.41797, 54.44788),
    (16, 'Al Reem Island', 24.49360, 54.40784),
    (17, 'Al Zahiyah', 24.49648, 54.37948),
    (18, 'Al Zeina', 24.45698, 54.61421),
    (19, 'Baniyas', 24.30648, 54.63486),
    (20, 'Corniche', 24.47419, 54.34019),
    (21, 'Khalifa City', 24.42013, 54.57495),
    (22, 'Mohamed Bin Zayed City', 24.33396, 54.55356),
    (23, 'Mussafah', 24.34887, 54.49044),
    (24, 'Rabdan', 24.40548, 54.50577),
    (25, 'Saadiyat Island', 24.54597, 54.44369),
    (26, 'Yas Island', 24.48837, 54.60723)
) as seed (id, name, lat, lng)
on conflict (id) do update
set name = excluded.name, location = excluded.location, sort = excluded.sort;

insert into auth.users (
  instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
  confirmation_token, email_change, email_change_token_new,
  email_change_token_current, recovery_token
)
select
  '00000000-0000-0000-0000-000000000000',
  users.id,
  'authenticated',
  'authenticated',
  users.email,
  extensions.crypt('SaveIt-dev-1', extensions.gen_salt('bf')),
  now(),
  '{"provider":"email","providers":["email"]}'::jsonb,
  '{}'::jsonb,
  now(),
  now(),
  '', '', '', '', ''
from (
  values
    ('a0000000-0000-4000-8000-000000000001'::uuid, 'admin.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000002'::uuid, 'customer.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000011'::uuid, 'corniche.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000012'::uuid, 'reem.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000013'::uuid, 'yas.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000014'::uuid, 'mina.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000015'::uuid, 'khalifa.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000016'::uuid, 'saadiyat.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000017'::uuid, 'mbz.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000018'::uuid, 'marina.dev@saveit.test')
) as users (id, email)
where not exists (
  select 1 from auth.users existing where existing.id = users.id
);

insert into auth.identities (
  id, user_id, identity_data, provider, provider_id,
  last_sign_in_at, created_at, updated_at
)
select
  users.id,
  users.id,
  jsonb_build_object('sub', users.id::text, 'email', users.email, 'email_verified', true),
  'email',
  users.id::text,
  now(),
  now(),
  now()
from (
  values
    ('a0000000-0000-4000-8000-000000000001'::uuid, 'admin.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000002'::uuid, 'customer.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000011'::uuid, 'corniche.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000012'::uuid, 'reem.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000013'::uuid, 'yas.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000014'::uuid, 'mina.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000015'::uuid, 'khalifa.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000016'::uuid, 'saadiyat.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000017'::uuid, 'mbz.dev@saveit.test'),
    ('a0000000-0000-4000-8000-000000000018'::uuid, 'marina.dev@saveit.test')
) as users (id, email)
where not exists (
  select 1
  from auth.identities existing
  where existing.user_id = users.id and existing.provider = 'email'
);

update public.profiles
set
  role = 'admin',
  full_name = 'Dev Admin',
  phone = '+971500000001',
  terms_accepted_at = coalesce(terms_accepted_at, now())
where id = 'a0000000-0000-4000-8000-000000000001';

update public.profiles
set
  role = 'customer',
  full_name = 'Dev Customer',
  phone = '+971500000002',
  terms_accepted_at = coalesce(terms_accepted_at, now())
where id = 'a0000000-0000-4000-8000-000000000002';

update public.profiles as profile
set
  role = 'restaurant',
  full_name = sample.full_name,
  phone = sample.phone,
  terms_accepted_at = coalesce(profile.terms_accepted_at, now())
from (
  values
    ('a0000000-0000-4000-8000-000000000011'::uuid, 'Corniche Kitchen', '+971500000011'),
    ('a0000000-0000-4000-8000-000000000012'::uuid, 'Reem Salad Bar', '+971500000012'),
    ('a0000000-0000-4000-8000-000000000013'::uuid, 'Yas Bakery', '+971500000013'),
    ('a0000000-0000-4000-8000-000000000014'::uuid, 'Mina Grill', '+971500000014'),
    ('a0000000-0000-4000-8000-000000000015'::uuid, 'Khalifa City Bites', '+971500000015'),
    ('a0000000-0000-4000-8000-000000000016'::uuid, 'Saadiyat Sweets', '+971500000016'),
    ('a0000000-0000-4000-8000-000000000017'::uuid, 'MBZ Family Kitchen', '+971500000017'),
    ('a0000000-0000-4000-8000-000000000018'::uuid, 'Marina Snack Bar', '+971500000018')
) as sample (id, full_name, phone)
where profile.id = sample.id;

insert into public.restaurants (
  id, user_id, name, address, location, phone, login_email, area_id, status, terms_accepted_at
)
select
  sample.id,
  sample.user_id,
  sample.name,
  sample.address,
  area.location,
  sample.phone,
  sample.login_email,
  sample.area_id,
  'active',
  now()
from (
  values
    ('b0000000-0000-4000-8000-000000000011'::uuid, 'a0000000-0000-4000-8000-000000000011'::uuid, 'Corniche Kitchen', 'Corniche Road', '+971500000011', 'corniche.dev@saveit.test', 20::smallint),
    ('b0000000-0000-4000-8000-000000000012'::uuid, 'a0000000-0000-4000-8000-000000000012'::uuid, 'Reem Salad Bar', 'Al Reem Island', '+971500000012', 'reem.dev@saveit.test', 16::smallint),
    ('b0000000-0000-4000-8000-000000000013'::uuid, 'a0000000-0000-4000-8000-000000000013'::uuid, 'Yas Bakery', 'Yas Island', '+971500000013', 'yas.dev@saveit.test', 26::smallint),
    ('b0000000-0000-4000-8000-000000000014'::uuid, 'a0000000-0000-4000-8000-000000000014'::uuid, 'Mina Grill', 'Al Mina', '+971500000014', 'mina.dev@saveit.test', 9::smallint),
    ('b0000000-0000-4000-8000-000000000015'::uuid, 'a0000000-0000-4000-8000-000000000015'::uuid, 'Khalifa City Bites', 'Khalifa City', '+971500000015', 'khalifa.dev@saveit.test', 21::smallint),
    ('b0000000-0000-4000-8000-000000000016'::uuid, 'a0000000-0000-4000-8000-000000000016'::uuid, 'Saadiyat Sweets', 'Saadiyat Island', '+971500000016', 'saadiyat.dev@saveit.test', 25::smallint),
    ('b0000000-0000-4000-8000-000000000017'::uuid, 'a0000000-0000-4000-8000-000000000017'::uuid, 'MBZ Family Kitchen', 'Mohamed Bin Zayed City', '+971500000017', 'mbz.dev@saveit.test', 22::smallint),
    ('b0000000-0000-4000-8000-000000000018'::uuid, 'a0000000-0000-4000-8000-000000000018'::uuid, 'Marina Snack Bar', 'Marina Mall', '+971500000018', 'marina.dev@saveit.test', 7::smallint)
) as sample (id, user_id, name, address, phone, login_email, area_id)
join public.areas as area on area.id = sample.area_id
on conflict (id) do update
set
  name = excluded.name,
  address = excluded.address,
  location = excluded.location,
  phone = excluded.phone,
  login_email = excluded.login_email,
  area_id = excluded.area_id,
  status = excluded.status;

insert into public.opening_hours (restaurant_id, weekday, opens_at, closes_at, is_closed)
select restaurant.id, weekday.day, time '10:00', time '22:00', false
from public.restaurants as restaurant
cross join generate_series(0, 6) as weekday (day)
where restaurant.id in (
  'b0000000-0000-4000-8000-000000000011',
  'b0000000-0000-4000-8000-000000000012',
  'b0000000-0000-4000-8000-000000000013',
  'b0000000-0000-4000-8000-000000000014',
  'b0000000-0000-4000-8000-000000000015',
  'b0000000-0000-4000-8000-000000000016',
  'b0000000-0000-4000-8000-000000000017',
  'b0000000-0000-4000-8000-000000000018'
)
on conflict (restaurant_id, weekday) do update
set opens_at = excluded.opens_at, closes_at = excluded.closes_at, is_closed = excluded.is_closed;

insert into public.pickup_windows (id, restaurant_id, date, starts_at, ends_at)
select
  sample.id,
  sample.restaurant_id,
  public.app_today(),
  (public.app_today() + time '16:00') at time zone 'Asia/Dubai',
  (public.app_today() + time '21:00') at time zone 'Asia/Dubai'
from (
  values
    ('d0000000-0000-4000-8000-000000000011'::uuid, 'b0000000-0000-4000-8000-000000000011'::uuid),
    ('d0000000-0000-4000-8000-000000000012'::uuid, 'b0000000-0000-4000-8000-000000000012'::uuid),
    ('d0000000-0000-4000-8000-000000000013'::uuid, 'b0000000-0000-4000-8000-000000000013'::uuid),
    ('d0000000-0000-4000-8000-000000000014'::uuid, 'b0000000-0000-4000-8000-000000000014'::uuid),
    ('d0000000-0000-4000-8000-000000000015'::uuid, 'b0000000-0000-4000-8000-000000000015'::uuid),
    ('d0000000-0000-4000-8000-000000000016'::uuid, 'b0000000-0000-4000-8000-000000000016'::uuid),
    ('d0000000-0000-4000-8000-000000000017'::uuid, 'b0000000-0000-4000-8000-000000000017'::uuid),
    ('d0000000-0000-4000-8000-000000000018'::uuid, 'b0000000-0000-4000-8000-000000000018'::uuid)
) as sample (id, restaurant_id)
on conflict (id) do update
set
  date = excluded.date,
  starts_at = excluded.starts_at,
  ends_at = excluded.ends_at;

insert into public.listings (
  id, restaurant_id, date, name, category_id,
  original_price, discounted_price, quantity, photo_path, status
)
select
  sample.id,
  sample.restaurant_id,
  public.app_today(),
  sample.name,
  category.id,
  sample.original_price,
  sample.discounted_price,
  4,
  null,
  'live'
from (
  values
    ('c0000000-0000-4000-8000-000000000011'::uuid, 'b0000000-0000-4000-8000-000000000011'::uuid, 'Grilled chicken plate', 'Savoury Dishes', 40.00, 16.00),
    ('c0000000-0000-4000-8000-000000000111'::uuid, 'b0000000-0000-4000-8000-000000000011'::uuid, 'Garden salad', 'Salads', 24.00, 10.00),
    ('c0000000-0000-4000-8000-000000000012'::uuid, 'b0000000-0000-4000-8000-000000000012'::uuid, 'Fattoush box', 'Salads', 28.00, 12.00),
    ('c0000000-0000-4000-8000-000000000112'::uuid, 'b0000000-0000-4000-8000-000000000012'::uuid, 'Lentil soup', 'Savoury Dishes', 18.00, 8.00),
    ('c0000000-0000-4000-8000-000000000013'::uuid, 'b0000000-0000-4000-8000-000000000013'::uuid, 'Cheese manakish', 'Bakery', 16.00, 7.00),
    ('c0000000-0000-4000-8000-000000000113'::uuid, 'b0000000-0000-4000-8000-000000000013'::uuid, 'Date maamoul', 'Sweet Treats', 22.00, 9.00),
    ('c0000000-0000-4000-8000-000000000014'::uuid, 'b0000000-0000-4000-8000-000000000014'::uuid, 'Fish sandwich', 'Savoury Dishes', 32.00, 14.00),
    ('c0000000-0000-4000-8000-000000000114'::uuid, 'b0000000-0000-4000-8000-000000000014'::uuid, 'Lemon mint', 'Beverages', 14.00, 6.00),
    ('c0000000-0000-4000-8000-000000000015'::uuid, 'b0000000-0000-4000-8000-000000000015'::uuid, 'Chicken shawarma', 'Savoury Dishes', 26.00, 11.00),
    ('c0000000-0000-4000-8000-000000000115'::uuid, 'b0000000-0000-4000-8000-000000000015'::uuid, 'Kids pasta box', 'Kids Menu', 20.00, 8.00),
    ('c0000000-0000-4000-8000-000000000016'::uuid, 'b0000000-0000-4000-8000-000000000016'::uuid, 'Baklava box', 'Sweet Treats', 36.00, 15.00),
    ('c0000000-0000-4000-8000-000000000116'::uuid, 'b0000000-0000-4000-8000-000000000016'::uuid, 'Karak tea', 'Beverages', 12.00, 5.00),
    ('c0000000-0000-4000-8000-000000000017'::uuid, 'b0000000-0000-4000-8000-000000000017'::uuid, 'Family rice tray', 'Savoury Dishes', 48.00, 20.00),
    ('c0000000-0000-4000-8000-000000000117'::uuid, 'b0000000-0000-4000-8000-000000000017'::uuid, 'Cucumber yogurt', 'Salads', 16.00, 7.00),
    ('c0000000-0000-4000-8000-000000000018'::uuid, 'b0000000-0000-4000-8000-000000000018'::uuid, 'Samosa pack', 'Snacks', 18.00, 8.00),
    ('c0000000-0000-4000-8000-000000000118'::uuid, 'b0000000-0000-4000-8000-000000000018'::uuid, 'Fruit cup', 'Snacks', 20.00, 8.00)
) as sample (id, restaurant_id, name, category_name, original_price, discounted_price)
join public.categories as category on category.name = sample.category_name
on conflict (id) do update
set
  date = excluded.date,
  name = excluded.name,
  category_id = excluded.category_id,
  original_price = excluded.original_price,
  discounted_price = excluded.discounted_price,
  quantity = greatest(excluded.quantity, public.listings.quantity_reserved),
  status = excluded.status;

insert into public.listing_tags (listing_id, tag_id)
select sample.listing_id, tag.id
from (
  values
    ('c0000000-0000-4000-8000-000000000111'::uuid, 'Vegetarian'),
    ('c0000000-0000-4000-8000-000000000012'::uuid, 'Vegetarian'),
    ('c0000000-0000-4000-8000-000000000112'::uuid, 'Vegan'),
    ('c0000000-0000-4000-8000-000000000013'::uuid, 'Vegetarian'),
    ('c0000000-0000-4000-8000-000000000116'::uuid, 'Vegan'),
    ('c0000000-0000-4000-8000-000000000117'::uuid, 'Vegetarian'),
    ('c0000000-0000-4000-8000-000000000018'::uuid, 'Vegetarian'),
    ('c0000000-0000-4000-8000-000000000118'::uuid, 'Gluten-free')
) as sample (listing_id, tag_name)
join public.dietary_tags as tag on tag.name = sample.tag_name
on conflict (listing_id, tag_id) do nothing;
