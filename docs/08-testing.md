# 08. Testing

The agreement promises automated tests for the core order flow. This file defines what that means, and the manual checks used before beta and launch.

## 1. Automated tests

| Layer | Tool | Covers | Location |
|---|---|---|---|
| Database | pgTAP (`supabase test db`, run in CI on a temporary stack) | RLS for every role; helper functions; `set_pickup_window`, listing rules, `reserve_order` (every error, all-or-nothing, concurrency), `confirm_pickup`, `cancel_order`, `expire_orders`, `refresh_customer_status`, `payout_summary`, account deletion anonymisation | `supabase/tests/` |
| App unit | `flutter test` + mocktail | Error mapping, models, basket notifier (limits, single restaurant, persistence), reserve controller (success, SI002, SI005), pass cache | `app/test/unit/` |
| App widget | `flutter test` | Basket → confirm → pickup pass; stock-changed state; suspended state; scan result screens | `app/test/widget/` |
| Admin | ESLint + TypeScript | Static checks | CI |

The **core order flow** is reserve, then pickup or cancel or expire, with stock and no-show effects. It is covered at two levels: database tests for the logic, and widget tests for the screens.

## 2. Concurrency test (CA-11)

The test creates a listing with 1 item left and opens two database sessions as two different customers. Both call `reserve_order` at the same time, using `dblink` (or two pgTAP connections in a shell script). Exactly one must succeed and the other must get SI005; `quantity_reserved` must end at 1.

## 3. Time-dependent tests

Business functions read the time through `app_now()`, which wraps `now()`. Tests override it using a session setting (`set local app.fake_now = '…'`), so expiry, reminders, windows and overnight hours can be tested without waiting.

## 4. End-to-end checklist (dev, before the M2 demo and the beta; on Android and the iOS TestFlight dev build)

1. Admin creates a restaurant using the address search.
2. The restaurant logs in, accepts the terms, sets today's window, adds 2 listings (one with a photo), and repeats yesterday's.
3. A guest browses with location allowed; again with location denied and an area picked; then applies filters and searches.
4. A first-time guest sees the walkthrough, adds to the basket, continues with email, enters the code, completes the profile, and reserves. The customer gets the push and email; the restaurant gets the new-order push.
5. The pass opens in airplane mode.
6. The restaurant scans the pass: the order is Collected. Scanning again shows "Already collected".
7. A second order is cancelled by the restaurant with a reason: stock comes back, and the customer gets the push and email.
8. A third order is left until the window ends: it is Expired, the stock is not returned, and the no-show count increases. Repeat until warned, then suspended. The admin lifts the suspension.
9. Admin exports CSV; the restaurant downloads the payout PDF and CSV; the totals match.
10. Deleting the account is blocked while an order is Reserved. After the order ends, the customer deletes the account: the orders show "Deleted customer" and the reports are unchanged.
11. Admin suspends the restaurant: it disappears from Explore, Business mode shows the banner with listing actions disabled, and an existing order can still be scanned. Scanning before the window starts shows "Too early".
12. Admin changes their own password and resets another admin's password.

## 5. Accessibility checklist (NF-09)

- [ ] At the largest system text size, every screen stays usable: nothing important is cut off and buttons can still be reached.
- [ ] Text contrast is at least 4.5:1 (body) and 3:1 (large text and icons). Check the terracotta-on-off-white combinations.
- [ ] Every icon-only button has a semantics label. TalkBack reads the Explore card, basket and pass correctly.
- [ ] Touch targets are at least 44×44.

## 6. Security checklist (NF-05)

- [ ] RLS is enabled on every table (`select relname from pg_class where relrowsecurity = false` returns only system tables).
- [ ] Every `security definer` function checks the role and sets `search_path`.
- [ ] The service-role key appears only in Edge Function secrets and Vercel server environment variables; a search of the app and the browser bundle finds nothing.
- [ ] Storage write policies are limited to the owner's path.
- [ ] The Google key is restricted to the Places API (New), with a quota cap.
- [ ] The login-code rate limit works (SI050). Admin password policy: at least 12 characters.
- [ ] Review demo accounts (T11.6) can only use password sign-in when their email is on the allow-list.

## 7. Client acceptance testing (M4)

- **Builds:** distributed through TestFlight and Google Play internal testing.
- **Who tests what:** the client tests on the devices in Q-07; the developer tests on Android.
- **Reporting:** issues are reported with the SRS ID, the steps and a screenshot, then logged as defects or Change Requests (Agreement §6.1–6.2).
- **Results:** Appendix A of the SRS is the checklist of record.
