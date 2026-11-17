# Week 9: Admin, part 1

**Mon 11 Jan to Fri 15 Jan 2027** · M3 Admin and Beta

**Goal:** Admins can log in, manage admins and passwords, and create and manage restaurants.

**End of week:** Admin on the dev Vercel deployment covering A-01 to A-04, A-10 and A-12.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T09.1 | Claude Code | Admin login, role guard, admins page with create (temporary password), deactivate and reset password; change own password (A-01, A-10, A-12) | AD-01, NF-05 | Non-admins blocked; deactivated admins cannot log in; admins cannot reset or deactivate themselves |
| [ ] | T09.2 | Claude Code | Restaurants list with search by name, area or login email, and status filter (A-02) | AD-02 | Pagination and search work |
| [ ] | T09.3 | Claude Code | Places proxy routes and `address-search` (UAE only, 3 characters, 300 ms, session tokens, field mask) | AD-03, NF-10 | One selection = one autocomplete session + one details call in Google Cloud metrics |
| [ ] | T09.4 | Claude Code | Restaurant form: logo, area, address search, opening hours with Closed toggles, login email (unique), phone; `admin-create-restaurant` (A-03) | AD-02 | A new restaurant can log in to Business mode immediately |
| [ ] | T09.5 | Claude Code | Suspend and unsuspend restaurants with audit log (A-04) | AD-02, BM-12 | Suspended restaurant disappears from Explore; its reserved orders can still be collected |
| [ ] | T09.6 | You | Check the admin in Chrome, Safari and Edge on the dev deployment | NF-02 | No layout or function issues |

## Friday update to Miss Reid

Admin dashboard: restaurants and admin accounts.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-09.md and these docs:
- docs/05-admin-web.md
- docs/03-backend-api.md §5–6

Implement the Claude Code tasks for this week, in order: T09.1, T09.2, T09.3, T09.4, T09.5.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-09.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
