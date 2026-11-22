-- T03.1. Enums and the reference tables from docs/02-database.md §1–2.
-- Business values are seeded from docs/srs/decisions.md. Do not hard-code them in clients.

create type public.user_role as enum ('customer', 'restaurant', 'admin');
create type public.customer_status as enum ('active', 'warned', 'suspended');
create type public.restaurant_status as enum ('active', 'suspended');
create type public.listing_status as enum ('draft', 'live', 'removed');
create type public.order_status as enum ('reserved', 'collected', 'cancelled', 'expired');
create type public.cancel_reason as enum ('sold_out', 'closing_early', 'customer_request', 'other');
create type public.outbox_channel as enum ('push', 'email');
create type public.outbox_state as enum ('pending', 'sent', 'failed');

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  role public.user_role not null default 'customer',
  full_name text,
  email text,
  phone text,
  terms_accepted_at timestamptz,
  status public.customer_status not null default 'active',
  status_changed_at timestamptz,
  suspension_lifted_at timestamptz,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  constraint profiles_phone_e164 check (
    phone is null or phone ~ '^\+[1-9][0-9]{6,14}$'
  )
);

comment on column public.profiles.suspension_lifted_at is
  'No-shows before this time are ignored. A suspension stays until an admin lifts it.';

create table public.areas (
  id smallint primary key,
  name text not null unique,
  location extensions.geography(Point, 4326) not null,
  sort smallint not null unique
);

comment on table public.areas is
  'Abu Dhabi area centres for customers who do not share a location. An admin can correct a centre later.';

create table public.restaurants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references public.profiles (id),
  name text not null,
  logo_path text,
  address text,
  place_id text,
  location extensions.geography(Point, 4326),
  phone text,
  login_email text not null unique,
  area_id smallint not null references public.areas (id),
  status public.restaurant_status not null default 'active',
  terms_accepted_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint restaurants_phone_e164 check (
    phone is null or phone ~ '^\+[1-9][0-9]{6,14}$'
  )
);

create table public.opening_hours (
  restaurant_id uuid not null references public.restaurants (id) on delete cascade,
  weekday smallint not null,
  opens_at time,
  closes_at time,
  is_closed boolean not null default false,
  primary key (restaurant_id, weekday),
  constraint opening_hours_weekday check (weekday between 0 and 6),
  constraint opening_hours_span check (
    is_closed or (opens_at is not null and closes_at is not null and opens_at <> closes_at)
  )
);

comment on column public.opening_hours.weekday is '0 is Sunday through 6 is Saturday.';
comment on table public.opening_hours is
  'When closes_at is earlier than opens_at, the restaurant closes after midnight.';

create table public.categories (
  id smallint primary key,
  name text not null unique,
  sort smallint not null unique
);

create table public.dietary_tags (
  id smallint primary key,
  name text not null unique,
  sort smallint not null unique
);

create table public.app_settings (
  key text primary key,
  value jsonb not null
);

comment on table public.app_settings is
  'Seeded from the signed business rules. Change values in a migration. There is no settings screen.';

insert into public.categories (id, name, sort)
values
  (1, 'Salads', 1),
  (2, 'Savoury Dishes', 2),
  (3, 'Sweet Treats', 3),
  (4, 'Beverages', 4),
  (5, 'Snacks', 5),
  (6, 'Bakery', 6),
  (7, 'Kids Menu', 7);

insert into public.dietary_tags (id, name, sort)
values
  (1, 'Vegetarian', 1),
  (2, 'Vegan', 2),
  (3, 'Gluten-free', 3),
  (4, 'Contains nuts', 4),
  (5, 'Lactose-free', 5);

insert into public.app_settings (key, value)
values
  ('commission_rate', '0.40'::jsonb),
  ('min_discount', '0.50'::jsonb),
  ('currency', '"AED"'::jsonb),
  ('pickup_earliest', '"16:00"'::jsonb),
  ('pickup_latest', '"23:30"'::jsonb),
  ('max_units_per_listing', '2'::jsonb),
  ('max_active_orders', '2'::jsonb),
  ('reminder_minutes', '30'::jsonb),
  ('noshow_warn_count', '2'::jsonb),
  ('noshow_warn_period_days', '7'::jsonb),
  ('noshow_suspend_count', '3'::jsonb),
  ('noshow_suspend_period_days', '30'::jsonb),
  ('search_radius_m', '10000'::jsonb),
  ('support_email', '"contact@arisehub.org"'::jsonb),
  ('prices_include_vat', 'true'::jsonb);

-- Centres are latitude then longitude in the decision log. PostGIS takes longitude first.
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
) as seed (id, name, lat, lng);

alter table public.profiles enable row level security;
alter table public.areas enable row level security;
alter table public.restaurants enable row level security;
alter table public.opening_hours enable row level security;
alter table public.categories enable row level security;
alter table public.dietary_tags enable row level security;
alter table public.app_settings enable row level security;
