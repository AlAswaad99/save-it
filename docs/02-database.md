# 02. Database

Postgres on Supabase, with the extensions `postgis`, `pg_cron`, `pg_net` and `pgcrypto`. Every change goes in a migration in `supabase/migrations/`. Never change the hosted databases by hand.

## 1. Enums

```sql
create type user_role         as enum ('customer', 'restaurant', 'admin');
create type customer_status   as enum ('active', 'warned', 'suspended');
create type restaurant_status as enum ('active', 'suspended');
create type listing_status    as enum ('draft', 'live', 'removed');
create type order_status      as enum ('reserved', 'collected', 'cancelled', 'expired');
create type cancel_reason     as enum ('sold_out', 'closing_early', 'customer_request', 'other');
create type outbox_channel    as enum ('push', 'email');
create type outbox_state      as enum ('pending', 'sent', 'failed');
```

`customer_request` is used only by admins (AD-04). Restaurants choose from `sold_out`, `closing_early` and `other` (BM-10).

## 2. Tables

### profiles
One row per auth user. A trigger on `auth.users` insert creates it on first sign-in with `role = customer` and empty name and phone. The app sends new customers to "Complete your profile" (C-13) until `complete_profile` has filled `full_name`, `phone` and `terms_accepted_at`.

| Column | Type | Notes |
|---|---|---|
| id | uuid PK | references `auth.users(id)` on delete cascade |
| role | user_role | default `customer`; set by the admin functions for restaurant and admin users |
| full_name | text | null until the profile is completed; required before reserving. A customer can change this directly |
| email | text | copy of the auth email, for search. Not writable by the customer |
| phone | text | customers; E.164 format (+971…). A customer can change this directly |
| terms_accepted_at | timestamptz | required for customers (CA-03) |
| status | customer_status | default `active` |
| status_changed_at | timestamptz | |
| suspension_lifted_at | timestamptz | no-shows before this time are ignored (SR-04) |
| is_active | boolean | for admins (deactivate, AD-01) |
| created_at | timestamptz | default now() |

A customer update may change only `full_name` and `phone`. Any other column raises SI001. `complete_profile` sets the transaction setting `app.trusted_profile_write` to `on` before it writes `terms_accepted_at`. `listings.quantity_reserved` is not granted to the API roles; order RPCs change it as the table owner.

### areas
The fallback list of Abu Dhabi areas for customers who don't share their location (CA-02). Seed these names, in this order. Centres are decimal degrees, latitude then longitude. In PostGIS that is `ST_MakePoint(longitude, latitude)`. They are neighbourhood centroids gathered on 21 November 2026, not surveyed pins, and an admin can correct them later.

| Name | Latitude | Longitude | How it was chosen |
|---|---|---|---|
| Al Bahyah | 24.55653 | 54.66416 | OpenStreetMap administrative area |
| Al Bateen | 24.45138 | 54.33797 | OpenStreetMap administrative area in Abu Dhabi. A same-named place in Al Ain was ignored |
| Al Danah | 24.48529 | 54.36989 | OpenStreetMap administrative area |
| Al Hisn | 24.48250 | 54.35085 | OpenStreetMap administrative area. The sheet spelled this "Al Hisin" |
| Al Hudayriyat Island | 24.41706 | 54.36027 | OpenStreetMap suburb |
| Al Khalidiya | 24.46934 | 54.34881 | OpenStreetMap administrative area. The map spells it Al Khalidiyah |
| Al Marina | 24.47604 | 54.32143 | Marina Mall. No district polygon is named Al Marina |
| Al Maryah Island | 24.50298 | 54.38997 | OpenStreetMap administrative area |
| Al Mina | 24.51828 | 54.37594 | Apple Maps place centroid for Al Mina |
| Al Muneera | 24.45161 | 54.60542 | OpenStreetMap neighbourhood on Al Raha Beach |
| Al Mushrif | 24.44109 | 54.38422 | OpenStreetMap administrative area |
| Al Nahyan | 24.46446 | 54.38684 | OpenStreetMap administrative area |
| Al Qana | 24.40400 | 54.49189 | GPS published on alqana.ae. It sits in Rabdan, beside Khor Al Maqta |
| Al Raha | 24.44785 | 54.59630 | OpenStreetMap suburb |
| Al Rawdah | 24.41797 | 54.44788 | OpenStreetMap administrative area near the airport. A smaller island neighbourhood of the same name is not used |
| Al Reem Island | 24.49360 | 54.40784 | OpenStreetMap administrative area |
| Al Zahiyah | 24.49648 | 54.37948 | OpenStreetMap administrative area |
| Al Zeina | 24.45698 | 54.61421 | OpenStreetMap neighbourhood on Al Raha Beach |
| Baniyas | 24.30648 | 54.63486 | OpenStreetMap administrative area. The map spells it Bani Yas |
| Corniche | 24.47419 | 54.34019 | OpenStreetMap point for Corniche Beach. The Corniche is a waterfront, not a district polygon |
| Khalifa City | 24.42013 | 54.57495 | OpenStreetMap administrative area |
| Mohamed Bin Zayed City | 24.33396 | 54.55356 | OpenStreetMap suburb |
| Mussafah | 24.34887 | 54.49044 | OpenStreetMap administrative area. The map spells it Musaffah |
| Rabdan | 24.40548 | 54.50577 | OpenStreetMap administrative area |
| Saadiyat Island | 24.54597 | 54.44369 | OpenStreetMap island |
| Yas Island | 24.48837 | 54.60723 | OpenStreetMap administrative area |

| Column | Type | Notes |
|---|---|---|
| id | smallint PK | |
| name | text unique | |
| location | geography(Point) | centre point of the area, used as the search origin |
| sort | smallint | |

### restaurants

| Column | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid unique | the restaurant's single login (`profiles.id`) |
| name | text | |
| logo_path | text | storage path in `restaurant-logos` |
| address | text | formatted address from Places |
| place_id | text | Google place ID, stored so the place is never looked up again (AD-03) |
| location | geography(Point, 4326) | GIST index |
| phone | text | |
| login_email | text unique | receives the Business mode codes |
| area_id | smallint | references `areas`; used for admin search and filtering (AD-02) |
| status | restaurant_status | |
| terms_accepted_at | timestamptz | set at first login (BM-01) |
| created_at, updated_at | timestamptz | |

### opening_hours
Primary key `(restaurant_id, weekday)`. `weekday` runs from 0 (Sunday) to 6. Columns: `opens_at time`, `closes_at time` and `is_closed boolean`. When `closes_at < opens_at`, the restaurant closes after midnight.

### categories, dietary_tags
Fixed lists seeded from BR-11 and BR-12. Columns: `id smallint`, `name text unique` and `sort smallint`. There is no editing UI (SR-09).

Categories, in order: Salads, Savoury Dishes, Sweet Treats, Beverages, Snacks, Bakery, Kids Menu.

Dietary tags, in order: Vegetarian, Vegan, Gluten-free, Contains nuts, Lactose-free. Halal is not in the client's list.

### pickup_windows

| Column | Type | Notes |
|---|---|---|
| id | uuid PK | |
| restaurant_id | uuid | |
| date | date | must equal `app_today()` when set |
| starts_at, ends_at | timestamptz | `starts_at < ends_at`; within opening hours and the BR-04 bounds; same day |
| | | unique `(restaurant_id, date)`: one window per day (SR-02) |

The window can be edited during the day. If orders exist, `ends_at` can only move later, and `starts_at` cannot change after the window has started.

### listings

| Column | Type | Notes |
|---|---|---|
| id | uuid PK | |
| restaurant_id | uuid | |
| date | date | the day it is offered |
| name | text | |
| category_id | smallint | |
| original_price, discounted_price | numeric(10,2) | the trigger enforces `discounted_price <= original_price * (1 - min_discount)` (SR-01) |
| quantity | int > 0 | |
| quantity_reserved | int ≥ 0 | changed only by RPCs; check `quantity >= quantity_reserved` (BM-05) |
| photo_path | text null | `listing-photos/{restaurant_id}/{uuid}.jpg` |
| status | listing_status | |
| copied_from_id | uuid null | set by "Repeat yesterday" (BM-04) |
| created_at, updated_at | timestamptz | |

`listing_tags(listing_id, tag_id)` has a composite primary key.

### orders

| Column | Type | Notes |
|---|---|---|
| id | uuid PK | |
| code | char(6) unique | alphabet `ABCDEFGHJKLMNPQRSTUVWXYZ23456789` (no 0, O, 1, I); retry on collision |
| customer_id | uuid null | null after account deletion |
| customer_name | text | first-name snapshot; "Deleted customer" after deletion |
| restaurant_id | uuid | |
| pickup_window_id | uuid | |
| status | order_status | |
| total | numeric(10,2) | sum of the line totals |
| commission_rate | numeric(5,4) | copied from `app_settings` when the order is created |
| commission_amount | numeric(10,2) | `round(total * rate, 2)`; the total is the discounted amount the customer pays (Q-01) |
| cancel_reason | cancel_reason null | |
| cancel_note | text null | required when the reason is `other` |
| cancelled_by | uuid null | |
| reminder_sent_at | timestamptz null | stops the reminder being sent twice |
| reserved_at, collected_at, cancelled_at, expired_at | timestamptz | |

`order_items` has these columns: `order_id`, `listing_id`, `name` (snapshot), `unit_price`, `original_price`, `quantity` and `line_total`.

### app_settings
Key-value configuration, seeded from the signed Business Rules Sheet. There is no admin UI: the developer changes values in a migration (SR-09, and the lean exclusion).

| key | Seed value | Source |
|---|---|---|
| commission_rate | `0.40` | BR-01, Q-01. 40% of the amount the customer pays |
| min_discount | `0.50` | BR-02. A listing must be at least half off |
| currency | `"AED"` | BR-03 |
| pickup_earliest, pickup_latest | `"16:00"`, `"23:30"` | BR-04, Asia/Dubai. The sheet wrote "16:00pm" and "23:30pm"; both are 24-hour times |
| max_units_per_listing | `2` | BR-05. Per listing, not per order |
| max_active_orders | `2` | BR-06 |
| reminder_minutes | `30` | BR-07. Before the window ends |
| noshow_warn_count, noshow_warn_period_days | `2`, `7` | BR-08. "One week" is a rolling 7 days |
| noshow_suspend_count, noshow_suspend_period_days | `3`, `30` | BR-09 |
| search_radius_m | `10000` | CA-02. Not in the answer sheet; unchanged |
| support_email | `"contact@arisehub.org"` | BR-19 |
| prices_include_vat | `true` | Q-02. The app shows "incl. VAT" |

Do not seed a single `noshow_period_days`. Warning and suspension use different windows.

The helper `setting(key text) returns jsonb` is `stable`. Business functions read every value through it.

### Other tables

| Table | Purpose |
|---|---|
| device_tokens | `(user_id, token unique, platform, updated_at)`: FCM tokens, upserted on login and app start, deleted on logout |
| outbox | `(id, channel, recipient_user_id, template, payload jsonb, state, attempts, next_attempt_at, last_error, created_at, sent_at)` |
| audit_log | `(id, actor_id, action, target_type, target_id, detail jsonb, created_at)`: admin actions |
| auth_code_requests | `(id, email, requested_at)`: login-code attempts for the 3-per-hour limit. No client access. `reserve_login_code` is called by the `auth-send-email` function |

## 3. Indexes

- `restaurants using gist(location)`
- `listings (restaurant_id, date, status)`
- `orders (customer_id, status)`, `orders (restaurant_id, reserved_at desc)`, `orders (status, pickup_window_id)` (for the expiry job)
- `pickup_windows (date, ends_at)`
- `outbox (state, next_attempt_at)`
- `profiles (lower(email))`, `profiles (phone)`, and a trigram index on `full_name` for admin search (enable `pg_trgm`)

## 4. Helper functions

| Function | Returns | Notes |
|---|---|---|
| `app_now()` | timestamptz | `now()`, unless tests override it with `set local app.fake_now` |
| `app_today()` | date | today in Asia/Dubai, based on `app_now()` |
| `app_role()` | user_role | from the JWT claim, falling back to `profiles` |
| `is_admin()` | boolean | |
| `my_restaurant_id()` | uuid | the restaurant whose `user_id = auth.uid()` |
| `is_open_now(restaurant_id)` | boolean | today's opening hours, overnight-aware |
| `listing_is_visible(listing)` | boolean | live, today, stock left, window not ended, restaurant open now and active (BM-06) |
| `restaurant_is_active(restaurant_id)` | boolean | used to block listing actions while suspended (BM-12, SI013) |
| `generate_order_code()` | text | random 6 characters from the safe alphabet |

## 5. Row-level security matrix

Key: R = read, W = insert/update, D = delete, — = no access. Anything marked "RPC" is changed only through functions.

| Table | anon | customer | restaurant | admin |
|---|---|---|---|---|
| profiles | — | R/W own (name, phone) | R own | R/W all |
| areas, categories, dietary_tags | R | R | R | R |
| restaurants | through the public RPCs only | through the public RPCs only | R own; W `terms_accepted_at` only, through RPC | R/W all |
| opening_hours | through the public RPCs | through the public RPCs | R own | R/W |
| pickup_windows | through the public RPCs | through the public RPCs | R own; W through `set_pickup_window` | R |
| listings | through the public RPCs | through the public RPCs | R/W/D own (not `quantity_reserved`) | R |
| orders, order_items | — | R own | R own restaurant | R; W through RPC |
| app_settings | R (public keys only, via `public_settings()`) | same | same | R |
| device_tokens | — | R/W/D own | R/W/D own | — |
| outbox, audit_log | — | — | — | R |

Every policy has a pgTAP test in `supabase/tests/rls_*.test.sql` (see 08-testing.md).

## 6. Scheduled jobs (pg_cron)

| Job | Schedule | What it does | Req |
|---|---|---|---|
| `expire_orders` | every 5 min | Sets `reserved` orders whose window `ends_at < now()` to `expired` (stock is not returned), then calls `refresh_customer_status(customer_id)` for each affected customer and queues an `order_expired` push | SR-03, SR-04 |
| `send_reminders` | every 5 min | For `reserved` orders whose window ends within `reminder_minutes` and that have no `reminder_sent_at`: queue a reminder push and set `reminder_sent_at` | CA-15 |
| `dispatch_outbox` | every 1 min | Calls the `dispatch` Edge Function through pg_net when there are pending rows | 06 |
| `cleanup` | daily 03:00 GST | Removes `sent` outbox rows older than 30 days, and stale device tokens (not updated for 90 days) | — |

`refresh_customer_status(customer)` counts expired orders after `suspension_lifted_at`.
- **Warning:** if at least `noshow_warn_count` of those orders expired inside `noshow_warn_period_days`, the status becomes `warned`.
- **Suspension:** if at least `noshow_suspend_count` expired inside `noshow_suspend_period_days`, the status becomes `suspended`.

Lifting a suspension (AD-04) sets `suspension_lifted_at = now()` and the status to `active`. A suspension stays until an admin lifts it (BR-10). It does not end by itself after a week.

## 7. Storage buckets

| Bucket | Read | Write | Limits |
|---|---|---|---|
| `restaurant-logos` | public | admin only | ≤ 1 MB, jpg/png/webp |
| `listing-photos` | public | restaurant, only under `{my_restaurant_id()}/` | ≤ 1 MB, jpg/webp; resized on the phone to max 1200 px, quality 80 |

Photos of removed listings are kept, because listings from earlier days still reference them. A cleanup task could be added later (see the roadmap).
