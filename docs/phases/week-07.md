# Week 7: Reservation, pickup pass and order history

**Mon 28 Dec to Fri 1 Jan 2027** · M2 Core Build

**Goal:** Customers reserve, get a pickup pass that works offline, and see their orders.

**End of week:** Reserve to pickup pass works on both platforms; concurrency test passes.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T07.1 | Claude Code | `reserve_order`: locking, limits, suspension, window, code generation, price and commission snapshot, outbox rows | CA-11, SR-06, SR-07 | Behaves exactly as `03-backend-api.md` §3 |
| [ ] | T07.2 | Claude Code | pgTAP for `reserve_order`: every error code, all-or-nothing, two sessions on the last item | CA-11 | Concurrency test shows exactly one success |
| [ ] | T07.3 | Claude Code | Confirm reservation and stock-changed handling (C-16, C-17) | CA-11, CA-12 | SI005 highlights the right item and updates the stepper |
| [ ] | T07.4 | Claude Code | Pickup pass: QR, code, countdown, directions (C-19) | CA-13 | QR reads `saveit:v1:{code}`; codes never contain 0, O, 1 or I |
| [ ] | T07.5 | Claude Code | Offline pass cache and banner | CA-13 | In airplane mode an active pass still opens |
| [ ] | T07.6 | Claude Code | `my_orders`, Orders tabs, order details variants (C-20, C-21) | CA-14 | Cancelled shows the reason; expired shows the no-show note |
| [ ] | T07.7 | Claude Code | Refresh order status on resume and pull-to-refresh | CA-14 | Status updates within one refresh |
| [ ] | T07.8 | Claude Code | `my_status`, no-show warning banner and suspended state (C-25, C-26) | CA-17, SR-04 | Suspended customer sees the message instead of Reserve |
| [ ] | T07.9 | Claude Code | Notification permission after the first reservation (C-18); token saved | CA-15 | Token stored in `device_tokens` |

## Friday update to Miss Reid

Reserving and the pickup pass are working, including offline.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-07.md and these docs:
- docs/01-architecture.md §4.1
- docs/03-backend-api.md §3
- docs/08-testing.md §2

Implement the Claude Code tasks for this week, in order: T07.1, T07.2, T07.3, T07.4, T07.5, T07.6, T07.7, T07.8, T07.9.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-07.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
