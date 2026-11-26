# 03. Backend API

The apps talk to Supabase in three ways:
1. **RPCs:** Postgres functions, called with `supabase.rpc(...)`.
2. **Direct table access:** limited by RLS; used for simple reads and writes of a user's own data.
3. **Edge Functions:** used for anything that needs secrets, the Auth admin API, or produces files.

## 1. Error codes

RPCs raise errors with `raise exception using errcode = 'P0001', message = 'SIxxx', detail = <json>`. The app maps each `SIxxx` code to a message in `app/lib/core/errors/error_messages.dart`. The admin web does the same in `admin/lib/errors.ts`.

| Code | Meaning | Detail |
|---|---|---|
| SI001 | Not allowed for this role | — |
| SI002 | Customer suspended | `{support_email}` |
| SI003 | Too many active orders | `{max}` |
| SI004 | Quantity over the per-listing limit | `{listing_id, max}` |
| SI005 | Not enough stock | `{listing_id, available}` |
| SI006 | Listing not available (removed, not today, window ended, restaurant closed) | `{listing_id}` |
| SI007 | Basket has items from more than one restaurant | — |
| SI010 | Pickup window outside opening hours or the allowed pickup times | `{opens, closes, earliest, latest}` |
| SI011 | Pickup window must be today | — |
| SI012 | Window change conflicts with existing orders | — |
| SI013 | Restaurant suspended: listing actions not allowed | `{support_email}` |
| SI020 | Discount below the minimum | `{min_discount}` |
| SI021 | Quantity lower than the amount already reserved | `{reserved}` |
| SI030 | Code not found for this restaurant | — |
| SI031 | Order already collected | `{collected_at}` |
| SI032 | Order expired | — |
| SI033 | Order cancelled | `{reason}` |
| SI034 | Pickup window not started yet | `{starts_at}` |
| SI040 | Cancel reason required | — |
| SI041 | Order can't be cancelled in its current status | `{status}` |
| SI050 | Too many login codes requested | `{retry_after_min}` |
| SI051 | Profile not completed (name, phone or terms missing) | — |
| SI060 | Account can't be deleted while a Reserved order exists | `{order_id}` |
| SI070 | Admin cannot reset or deactivate their own account | — |

## 2. Public RPCs (guest and customer)

| Function | Arguments | Returns | Req |
|---|---|---|---|
| `nearby_restaurants` | `lat, lng, radius_m default setting, category_id null, tag_ids smallint[] null, q text null` | Rows of `{id, name, logo_url, distance_m, window_start, window_end, min_price, items_left}`. Only active restaurants that are open now and have at least one visible listing. Ordered by distance. | CA-06, CA-07 |
| `restaurant_detail` | `restaurant_id` | Restaurant info, today's opening hours, today's window, lat/lng (for Directions) | CA-08 |
| `restaurant_listings` | `restaurant_id` | Visible listings: id, name, category, tags, prices, `quantity - quantity_reserved`, photo_url, plus the `max_units_per_listing` setting | CA-08, CA-09 |
| `public_settings` | — | `{currency, max_units_per_listing, max_active_orders, support_email, prices_include_vat, search_radius_m}` | — |

## 3. Customer RPCs

| Function | Arguments | Returns | Req |
|---|---|---|---|
| `complete_profile` | `full_name, phone, accept_terms boolean` | Fills the profile for a new customer (C-13) and queues the `welcome` email. Fails with SI051 unless `accept_terms` is true and the name and E.164 phone are present. A later call updates the name and phone and does not queue the email again. | CA-03 |
| `reserve_order` | `restaurant_id, items jsonb [{listing_id, quantity}]` | `{order_id, code, total, window_start, window_end}`. All or nothing. Errors SI002–SI007. | CA-11, SR-06, SR-07 |
| `my_orders` | `scope text ('active'\|'past')` | Orders with the restaurant name, address, lat/lng, window, items, status, cancel reason | CA-14 |
| `my_status` | — | `{status, noshow_count, warn_at, suspend_at}`, used for the C-25 and C-26 banners | CA-17, SR-04 |

**`reserve_order`** does the following in one transaction:
1. Checks that the caller is a customer, that their profile is complete (SI051) and that their status is not `suspended`.
2. Checks that their active `reserved` orders number fewer than `max_active_orders`.
3. Locks the listings with `SELECT … FOR UPDATE ORDER BY id`. The fixed order prevents deadlocks.
4. For each item, checks that the listing belongs to `restaurant_id` and is visible, and that `quantity` is at most `max_units_per_listing` and at most what's available.
5. Inserts the order and its items, copying in the prices and `commission_rate`.
6. Increases `quantity_reserved`.
7. Queues `order_confirmed` (push and email to the customer) and `new_order` (push to the restaurant).

## 4. Restaurant RPCs

| Function | Arguments | Returns | Req |
|---|---|---|---|
| `accept_restaurant_terms` | — | — | BM-01 |
| `set_pickup_window` | `starts_at time, ends_at time` | the window. Errors SI010–SI012 | BM-02, SR-02 |
| `today_summary` | — | `{window, live_listings, items_left, reserved, collected}` | B-03 |
| `copy_yesterday_listings` | — | Draft listings created for today from the previous day's listings that had status live. Skips any already copied. SI013 while suspended. | BM-04 |
| `publish_listings` | `listing_ids uuid[]` | Sets them to `live`. Requires today's window to be set. SI013 while suspended. | BM-03, BM-04, BM-12 |
| `restaurant_orders` | `status order_status null` | Today's orders, newest first, with customer first name and items | BM-08 |
| `confirm_pickup` | `code text` | `{order_id, customer_name, items, total}`. Errors SI030–SI034 (SI034 = Too early). Works while the restaurant is suspended. | BM-09, BM-12 |
| `cancel_order` | `order_id, reason, note null` | Restaurants and admins. Returns stock if the window is still open, then queues `order_cancelled` (push and email). | BM-10, SR-05, AD-04 |
| `payout_summary` | `month date` | `{orders, sales, commission, due}` plus the rows. Restaurants see only their own; admins can pass `restaurant_id`. | BM-11 |

Listings are created and edited directly on the `listings` table under RLS, with trigger validation (SI020, SI021). Removing a listing sets `status = 'removed'`, and existing orders keep their items.

## 5. Admin RPCs

| Function | Arguments | Req |
|---|---|---|
| `admin_set_customer_status` | `user_id, action ('suspend'\|'lift')` | AD-04, SR-04 |
| `admin_set_restaurant_status` | `restaurant_id, status` | AD-02 |
| `admin_search_orders` | `q, date_from, date_to, restaurant_id, status, page` | AD-04 |
| `admin_search_customers` | `q, status, page` | AD-04 |
| `admin_export_orders` | `date_from, date_to, restaurant_id null` → rows for CSV | AD-05 |

Every admin RPC starts with `if not is_admin() then raise 'SI001'` and writes to `audit_log`.

## 6. Edge Functions

| Function | Called by | Purpose | Req |
|---|---|---|---|
| `auth-send-email` | Supabase Auth (Send Email Hook) | Sends the login-code email through Resend. Enforces 3 codes per email per hour (SI050). Verifies the hook signature. A limit or failure is returned as HTTP 200 with `{error: {http_code, message}}`, which is the only shape Auth will pass on to the app. | CA-04, BM-01 |
| `dispatch` | pg_cron through pg_net | Drains `outbox`: FCM HTTP v1 for push (removes invalid tokens), Resend for email. Retries with backoff, up to 5 attempts. | CA-15, CA-16, BM-07 |
| `admin-create-restaurant` | Admin web | Creates the auth user (email, role `restaurant`), the profile, the restaurant row and its opening hours, all or nothing | AD-02 |
| `admin-create-admin` | Admin web | Creates an admin user with a temporary password. Deactivating an admin bans the auth user and sets `profiles.is_active = false`. | AD-01 |
| `admin-reset-password` | Admin web | Sets a new temporary password for another admin and returns it once (SI070 for yourself). Admins change their own password through Supabase Auth after re-entering the current one (A-12, minimum 12 characters). | AD-01 |
| `delete-account` | Customer app | Refuses with SI060 while the caller has a Reserved order. Otherwise anonymises their orders and deletes their device tokens, profile and auth user. | CA-05 |
| `payout-report` | App and admin | `?month=YYYY-MM&format=pdf\|csv[&restaurant_id=]`: builds the file from `payout_summary` (pdf-lib) and returns it | BM-11 |

All functions check the caller's JWT and role, except `auth-send-email` and `dispatch`, which check a shared secret or the hook signature.
