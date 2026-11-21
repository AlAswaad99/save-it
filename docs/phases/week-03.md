# Week 3: Database and authentication

**Mon 30 Nov to Fri 4 Dec 2026** · M2 Core Build

**Goal:** The full database, security rules and email-code login running on the dev project.

**End of week:** All tables, RLS and helpers on dev; login code emails arrive; Flutter data layer ready.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T03.1 | Claude Code | Migration 1: enums, profiles, areas, restaurants (with `area_id`), opening_hours, categories, dietary_tags, app_settings seeded from `docs/srs/decisions.md` and `02-database.md` | SR-09, NF-06 | Tables match `02-database.md`; commission is 0.40, minimum discount is 0.50, and the category and area lists match the decision log |
| [ ] | T03.2 | Claude Code | Migration 2: pickup_windows, listings, listing_tags, orders, order_items, device_tokens, outbox, audit_log; constraints and indexes | SR-01–SR-08 | All constraints and indexes from `02-database.md` §2–3 exist |
| [ ] | T03.3 | Claude Code | Helper functions (`app_now`, `app_today`, `setting`, `is_admin`, `my_restaurant_id`, `is_open_now`, `generate_order_code`) and the trigger that creates a profile on first sign-in | SR-10 | pgTAP tests cover the helpers, including overnight hours and the Dubai date at 23:30 UTC |
| [ ] | T03.4 | Claude Code | RLS policies for every table; storage buckets and policies | NF-05 | Matches the matrix in `02-database.md` §5 |
| [ ] | T03.5 | Claude Code | pgTAP RLS tests for each role (anon, customer, restaurant, admin), including cross-tenant attempts | NF-05 | Each matrix cell has a passing test in CI |
| [ ] | T03.6 | Claude Code | Auth settings on dev (6-digit code, 10-minute expiry, admin password policy) and the `auth-send-email` hook with Resend and the 3-per-hour limit | CA-04, BM-01, AD-01 | A code email arrives; a 4th request within an hour returns SI050 |
| [ ] | T03.7 | Claude Code | Seed script for dev (`supabase/seed.sql`, run manually): areas, 8 sample restaurants with hours and listings, test users for every role | — | Dev has a usable dataset; script can be re-run safely |
| [ ] | T03.8 | Claude Code | Flutter data layer: Supabase client per flavor, RPC helper, SIxxx error mapping, base repository, freezed models for the core tables | — | Unit tests for the error mapping and model JSON pass |

## Friday update to Miss Reid

Backend foundation built: database, security rules and login emails working.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-03.md and these docs:
- docs/02-database.md
- docs/03-backend-api.md §1
- docs/08-testing.md §1–3

Implement the Claude Code tasks for this week, in order: T03.1, T03.2, T03.3, T03.4, T03.5, T03.6, T03.7, T03.8.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-03.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
