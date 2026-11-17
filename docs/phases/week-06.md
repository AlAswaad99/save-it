# Week 6: Customer discovery and basket

**Mon 21 Dec to Fri 25 Dec 2026** · M2 Core Build

**Goal:** Customers find nearby restaurants, filter and search, view items and build a basket.

**End of week:** Browse to basket works on dev, on Android and iOS test builds.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T06.1 | Claude Code | `nearby_restaurants`: PostGIS radius, filters, name search, nearest first; performance check with 200 seeded restaurants | CA-06, CA-07, NF-03 | Correct in tests; under 200 ms in `explain analyze` on dev |
| [ ] | T06.2 | Claude Code | Explore: location bar, search, filter chips, restaurant cards, pull-to-refresh, no-show warning slot (C-04) | CA-06 | Cards show distance, window, "From AED x" and items left |
| [ ] | T06.3 | Claude Code | Filters sheet, search results, empty states (C-05, C-06, C-07) | CA-07 | Filters combine and clear; empty states appear |
| [ ] | T06.4 | Claude Code | `restaurant_detail`, `restaurant_listings` and the restaurant page with Directions (C-08) | CA-08 | Directions opens the maps app at the restaurant |
| [ ] | T06.5 | Claude Code | Item details sheet with stepper capped by the limit and stock (C-09) | CA-09 | Stepper never exceeds min(limit, available) |
| [ ] | T06.6 | Claude Code | Basket notifier saved locally; single-restaurant dialog; basket bar (C-10) | CA-10 | Basket survives a restart; second restaurant asks to clear first |
| [ ] | T06.7 | Claude Code | Basket screen with the pay-at-counter note and active-order limit message (C-11) | CA-10, CA-12 | Totals correct in AED |
| [ ] | T06.8 | Claude Code | Loading skeletons, image caching, error and offline states across discovery | NF-03 | On throttled 4G, the list appears within 3 seconds |

## Friday update to Miss Reid

Customers can browse, filter, search and fill a basket.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-06.md and these docs:
- docs/03-backend-api.md §2
- docs/04-mobile-app.md §4–5

Implement the Claude Code tasks for this week, in order: T06.1, T06.2, T06.3, T06.4, T06.5, T06.6, T06.7, T06.8.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-06.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
