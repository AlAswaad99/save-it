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
| full_name | text | null until the profile is completed; required before reserving |
| email | text | copy of the auth email, for search |
| phone | text | customers; E.164 format (+971…) |
| terms_accepted_at | timestamptz | required for customers (CA-03) |
| status | customer_status | default `active` |
| status_changed_at | timestamptz | |
| suspension_lifted_at | timestamptz | no-shows before this time are ignored (SR-04) |
| is_active | boolean | for admins (deactivate, AD-01) |
| created_at | timestamptz | default now() |

### areas
The fallback list of Abu Dhabi areas for customers who don't share their location (CA-02). The values come from Business Rules Q-04.

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
| commission_amount | numeric(10,2) | `round(total * rate, 2)`; the basis comes from Q-02 |
| cancel_reason | cancel_reason null | |
| cancel_note | text null | required when the reason is `other` |
| cancelled_by | uuid null | |
| reminder_sent_at | timestamptz null | stops the reminder being sent twice |
| reserved_at, collected_at, cancelled_at, expired_at | timestamptz | |

`order_items` has these columns: `order_id`, `listing_id`, `name` (snapshot), `unit_price`, `original_price`, `quantity` and `line_total`.

### app_settings
Key-value configuration, seeded from the signed Business Rules Sheet. There is no admin UI: the developer changes values in a migration (SR-09, and the lean exclusion).

| key | Example value | Source |
|---|---|---|
| commission_rate | `0.15` | BR-01, Q-02 |
| min_discount | `0.40` | BR-02 |
| currency | `"AED"` | BR-03 |
| pickup_earliest, pickup_latest | `"17:00"`, `"23:00"` | BR-04 |
| max_units_per_listing | `3` | BR-05 |
| max_active_orders | `2` | BR-06 |
| reminder_minutes | `30` | BR-07 |
| noshow_warn_count, noshow_suspend_count, noshow_period_days | `2`, `3`, `30` | BR-08, BR-09 |
| search_radius_m | `10000` | CA-02 |
| support_email | `"support@…"` | BR-19 |
| prices_include_vat | `true` | Q-03 |

The helper `setting(key text) returns jsonb` is `stable`. Business functions read every value through it.

### Other tables

| Table | Purpose |
|---|---|
| device_tokens | `(user_id, token unique, platform, updated_at)`: FCM tokens, upserted on login and app start, deleted on logout |
| outbox | `(id, channel, recipient_user_id, template, payload jsonb, state, attempts, next_attempt_at, last_error, created_at, sent_at)` |
| audit_log | `(id, actor_id, action, target_type, target_id, detail jsonb, created_at)`: admin actions |

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

`refresh_customer_status(customer)` counts the expired orders that fall within `noshow_period_days` and after `suspension_lifted_at`.
- **Warning:** if the count is at least `noshow_warn_count`, the status becomes `warned`.
- **Suspension:** if the count is at least `noshow_suspend_count`, the status becomes `suspended`.

It never lowers a manual suspension. Lifting a suspension (AD-04) sets `suspension_lifted_at = now()` and the status to `active`.

## 7. Storage buckets

| Bucket | Read | Write | Limits |
|---|---|---|---|
| `restaurant-logos` | public | admin only | ≤ 1 MB, jpg/png/webp |
| `listing-photos` | public | restaurant, only under `{my_restaurant_id()}/` | ≤ 1 MB, jpg/webp; resized on the phone to max 1200 px, quality 80 |

Photos of removed listings are kept, because listings from earlier days still reference them. A cleanup task could be added later (see the roadmap).
