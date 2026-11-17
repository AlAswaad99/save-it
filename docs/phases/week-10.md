# Week 10: Admin, part 2, and notifications

**Mon 18 Jan to Fri 22 Jan 2027** · M3 Admin and Beta

**Goal:** Customers, orders and CSV export in the admin; all pushes and emails delivered.

**End of week:** Every notification in `06-notifications.md` fires on dev; admin AD-04 and AD-05 complete.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T10.1 | Claude Code | Customers list and details; suspend and lift (A-08, A-09) | AD-04, SR-04 | Lifting restarts no-show counting from that moment |
| [ ] | T10.2 | Claude Code | Orders list, filters, side panel, cancel with reason (A-05, A-06) | AD-04 | Search by code, name, email and phone works |
| [ ] | T10.3 | Claude Code | CSV export (A-07): items sold per restaurant and period | AD-05 | Opens correctly in Excel with the agreed columns |
| [ ] | T10.4 | Claude Code | `dispatch`: FCM HTTP v1, Resend, retries, invalid-token cleanup, idempotency | CA-15, CA-16, BM-07 | Failed sends retry; nothing is sent twice |
| [ ] | T10.5 | Claude Code | Outbox triggers for all events, `send_reminders` job, welcome email after Complete your profile | CA-15, CA-16, BM-07 | Every row in `06-notifications.md` fires on dev |
| [ ] | T10.6 | Claude Code | Email templates: welcome, confirmation, cancellation, restyled login code | CA-16 | Render correctly in Gmail and Outlook |
| [ ] | T10.7 | Claude Code | App push handling: foreground display, tap opens the right screen, Android 13 permission; APNs key in Firebase | CA-15, BM-07 | Each notification type opens the right screen from a killed app on Android and iPhone |

## Friday update to Miss Reid

Notifications and emails live; admin orders, customers and export done.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-10.md and these docs:
- docs/05-admin-web.md
- docs/06-notifications.md

Implement the Claude Code tasks for this week, in order: T10.1, T10.2, T10.3, T10.4, T10.5, T10.6, T10.7.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-10.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
