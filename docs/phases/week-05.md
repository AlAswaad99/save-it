# Week 5: Business mode: pickup window and listings

**Mon 14 Dec to Fri 18 Dec 2026** · M2 Core Build

**Goal:** Restaurants can set today's pickup window and post, repeat, edit and remove listings.

**End of week:** Restaurant side of a day works end to end on dev.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T05.1 | Claude Code | `set_pickup_window`: same day, within opening hours and the allowed pickup hours, limits on editing once orders exist; tests | BM-02, SR-02 | pgTAP covers SI010–SI012 |
| [ ] | T05.2 | Claude Code | Business shell (Today, Listings, Scan, Orders, Reports) and the Today screen, including the "window not set" state (B-03) | BM-02 | Counts match `today_summary` |
| [ ] | T05.3 | Claude Code | Set pickup window screen with both hints (B-04) | BM-02 | Pickers only allow valid times; errors shown inline |
| [ ] | T05.4 | Claude Code | Listing form: fields, category and tag pickers, live discount %, validation (B-07) | BM-03, BM-05, SR-01 | Discount below minimum and quantity below reserved are both blocked |
| [ ] | T05.5 | Claude Code | Photo from camera or gallery, compression, upload, default image by category | BM-03 | Uploads are 1200 px or smaller and under 1 MB |
| [ ] | T05.6 | Claude Code | Listing validation trigger (SI020, SI021, date = today), publish and remove | SR-01, BM-05 | pgTAP passes; removed listings keep their orders |
| [ ] | T05.7 | Claude Code | Listings list with status badges; remove confirmation (B-05, B-08) | BM-05, BM-06 | Draft, Live, Sold out and Hidden badges are correct |
| [ ] | T05.8 | Claude Code | `copy_yesterday_listings`, review drafts, Publish all (B-06) | BM-04 | Copies are editable drafts; running twice does not duplicate |
| [ ] | T05.9 | Claude Code | `listing_is_visible` (live, today, stock, window not ended, open now, restaurant active) with tests | BM-06 | Each hiding condition has a passing test |
| [ ] | T05.10 | Claude Code | Suspended restaurant rules: listing actions blocked (SI013), existing orders still viewable and scannable; banner on Today with actions disabled (B-03 suspended) | BM-12 | pgTAP and a widget test cover the suspended state |

## Friday update to Miss Reid

Restaurant tools working: pickup window, listings, repeat yesterday.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-05.md and these docs:
- docs/02-database.md §2, §4
- docs/03-backend-api.md §4
- docs/04-mobile-app.md §4–5

Implement the Claude Code tasks for this week, in order: T05.1, T05.2, T05.3, T05.4, T05.5, T05.6, T05.7, T05.8, T05.9, T05.10.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-05.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
