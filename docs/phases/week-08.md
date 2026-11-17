# Week 8: Pickup, cancellation, expiry and account deletion

**Mon 4 Jan to Fri 8 Jan 2027** · M2 Core Build

**Goal:** Close the order loop: scan to collect, cancel, expire, no-shows, and account deletion. Demo the full flow.

**End of week:** Milestone 2 demo recording sent to the client; core-flow tests green.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T08.1 | Claude Code | `confirm_pickup` with all result types, including Too early; tests | BM-09 | pgTAP covers SI030–SI034 and success |
| [ ] | T08.2 | Claude Code | Scan, manual code entry and result screens, including Too early (B-12, B-13, B-14) | BM-09 | Scan to Collected in under 2 seconds on your phone |
| [ ] | T08.3 | Claude Code | `restaurant_orders`, orders list with filters, order details (B-09, B-10) | BM-08 | Newest first; filters work |
| [ ] | T08.4 | Claude Code | `cancel_order` (stock back if window open) and cancel sheet (B-11); tests | BM-10, SR-05 | Reason required; stock only returns before the window ends |
| [ ] | T08.5 | Claude Code | `expire_orders` job and `refresh_customer_status` (warn, suspend, lifted_at); tests | SR-03, SR-04 | Fake-time tests move a customer to warned then suspended |
| [ ] | T08.6 | Claude Code | `delete-account` function and confirmation, blocked while a Reserved order exists (C-24 and its active-order state) | CA-05, NF-11 | Blocked with an active order; after deletion orders show "Deleted customer" and reports are unchanged |
| [ ] | T08.7 | Claude Code | Flutter core-flow tests: basket and reserve controller unit tests; widget test from reserve to pass | Agreement: core order flow tests | Run in CI and pass |
| [ ] | T08.8 | You | End-to-end run on dev (Android and the iOS TestFlight dev build); record the M2 demo and send it | — | Checklist in `08-testing.md` §4 steps 1–8 pass; video sent |

## Friday update to Miss Reid

Full order flow demo video (Milestone 2).

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-08.md and these docs:
- docs/01-architecture.md §4.2–4.3
- docs/02-database.md §6
- docs/03-backend-api.md §4, §6
- docs/08-testing.md §4

Implement the Claude Code tasks for this week, in order: T08.1, T08.2, T08.3, T08.4, T08.5, T08.6, T08.7.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-08.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
