-- T03.2. Listings, orders, and the indexes from docs/02-database.md §2–3.
-- Discount and pickup-window business rules are enforced later by their RPCs
-- (set_pickup_window, the listing trigger). This migration is the shape and
-- the constraints that do not need those functions.

create table public.pickup_windows (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references public.restaurants (id) on delete cascade,
  date date not null,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  constraint pickup_windows_one_per_day unique (restaurant_id, date),
  constraint pickup_windows_order check (starts_at < ends_at),
  constraint pickup_windows_same_day check (
    (starts_at at time zone 'Asia/Dubai')::date = date
    and (ends_at at time zone 'Asia/Dubai')::date = date
  )
);

comment on table public.pickup_windows is
  'One window per restaurant per day. starts_at and ends_at fall on date in Asia/Dubai.';

create table public.listings (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references public.restaurants (id),
  date date not null,
  name text not null,
  category_id smallint not null references public.categories (id),
  original_price numeric(10, 2) not null,
  discounted_price numeric(10, 2) not null,
  quantity int not null,
  quantity_reserved int not null default 0,
  photo_path text,
  status public.listing_status not null default 'draft',
  copied_from_id uuid references public.listings (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint listings_quantity_positive check (quantity > 0),
  constraint listings_reserved_nonnegative check (quantity_reserved >= 0),
  constraint listings_stock check (quantity >= quantity_reserved),
  constraint listings_prices_nonnegative check (
    original_price >= 0 and discounted_price >= 0
  )
);

comment on column public.listings.quantity_reserved is
  'Changed only by order RPCs. Clients must not update this column.';

create table public.listing_tags (
  listing_id uuid not null references public.listings (id) on delete cascade,
  tag_id smallint not null references public.dietary_tags (id),
  primary key (listing_id, tag_id)
);

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  code char(6) not null,
  customer_id uuid references public.profiles (id) on delete set null,
  customer_name text not null,
  restaurant_id uuid not null references public.restaurants (id),
  pickup_window_id uuid not null references public.pickup_windows (id),
  status public.order_status not null default 'reserved',
  total numeric(10, 2) not null,
  commission_rate numeric(5, 4) not null,
  commission_amount numeric(10, 2) not null,
  cancel_reason public.cancel_reason,
  cancel_note text,
  cancelled_by uuid references public.profiles (id),
  reminder_sent_at timestamptz,
  reserved_at timestamptz not null default now(),
  collected_at timestamptz,
  cancelled_at timestamptz,
  expired_at timestamptz,
  constraint orders_code_unique unique (code),
  constraint orders_code_alphabet check (
    code ~ '^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{6}$'
  ),
  constraint orders_other_needs_note check (
    cancel_reason is distinct from 'other'
    or (cancel_note is not null and length(btrim(cancel_note)) > 0)
  ),
  constraint orders_money_nonnegative check (
    total >= 0 and commission_rate >= 0 and commission_amount >= 0
  )
);

comment on column public.orders.code is
  'Six characters from ABCDEFGHJKLMNPQRSTUVWXYZ23456789. No 0, O, 1, or I.';
comment on column public.orders.commission_rate is
  'Copied from app_settings when the order is created.';
comment on column public.orders.commission_amount is
  'round(total * commission_rate, 2). total is the discounted amount the customer pays.';

create table public.order_items (
  order_id uuid not null references public.orders (id) on delete cascade,
  listing_id uuid not null references public.listings (id),
  name text not null,
  unit_price numeric(10, 2) not null,
  original_price numeric(10, 2) not null,
  quantity int not null,
  line_total numeric(10, 2) not null,
  primary key (order_id, listing_id),
  constraint order_items_quantity check (quantity > 0),
  constraint order_items_money_nonnegative check (
    unit_price >= 0 and original_price >= 0 and line_total >= 0
  )
);

create table public.device_tokens (
  user_id uuid not null references public.profiles (id) on delete cascade,
  token text not null,
  platform text not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, token),
  constraint device_tokens_token_unique unique (token)
);

create table public.outbox (
  id uuid primary key default gen_random_uuid(),
  channel public.outbox_channel not null,
  recipient_user_id uuid references public.profiles (id) on delete set null,
  template text not null,
  payload jsonb not null default '{}'::jsonb,
  state public.outbox_state not null default 'pending',
  attempts int not null default 0,
  next_attempt_at timestamptz not null default now(),
  last_error text,
  created_at timestamptz not null default now(),
  sent_at timestamptz,
  constraint outbox_attempts_nonnegative check (attempts >= 0)
);

create table public.audit_log (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references public.profiles (id),
  action text not null,
  target_type text not null,
  target_id uuid,
  detail jsonb,
  created_at timestamptz not null default now()
);

create index restaurants_location_idx
  on public.restaurants
  using gist (location);

create index listings_restaurant_date_status_idx
  on public.listings (restaurant_id, date, status);

create index orders_customer_status_idx
  on public.orders (customer_id, status);

create index orders_restaurant_reserved_idx
  on public.orders (restaurant_id, reserved_at desc);

create index orders_status_window_idx
  on public.orders (status, pickup_window_id);

create index pickup_windows_date_ends_idx
  on public.pickup_windows (date, ends_at);

create index outbox_state_next_idx
  on public.outbox (state, next_attempt_at);

create index profiles_email_lower_idx
  on public.profiles (lower(email));

create index profiles_phone_idx
  on public.profiles (phone);

create index profiles_full_name_trgm_idx
  on public.profiles
  using gin (full_name extensions.gin_trgm_ops);

alter table public.pickup_windows enable row level security;
alter table public.listings enable row level security;
alter table public.listing_tags enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.device_tokens enable row level security;
alter table public.outbox enable row level security;
alter table public.audit_log enable row level security;
