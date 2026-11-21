# Week 2: UI design and SRS sign-off

**Mon 23 Nov to Fri 27 Nov 2026** · M1 Discovery and Design

**Goal:** Approved UI designs, the business rules recorded in `docs/srs/decisions.md`, and the app theme in code. Also, backend deployment automated. A signed SRS v1.0 is not required.

**End of week:** Client-approved designs in `docs/save-it-design-handoff/`; theme and core widgets in the app.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [x] | T02.1 | You | UI design in Claude Design from `docs/design/ui-design-prompt.md`: style guide, then all customer, Business mode and admin screens | All | Every wireframe screen has a designed version; style guide is one page |
| [x] | T02.2 | You | Check the designs against the decisions and wireframes; client design review; fixes. Approval was given on 22 Nov 2026 for the wireframes and the high-fidelity UI | — | Approved exports in `docs/save-it-design-handoff/`. Suspension stays until an admin lifts it. The approved UI keeps the "No nuts" filter and the empty title "No food near you right now" |
| [x] | T02.3 | You | Skipped 22 Nov 2026. No signed SRS. The client approved the wireframes and the high-fidelity design. The numeric rules stay in `docs/srs/decisions.md`. Terms and the privacy policy are still to come | All | Recorded as skipped. No signed file required |
| [x] | T02.4 | Claude Code | Flutter theme from the approved style guide, or from the brand files in `docs/businessrules-and-contents/` if the style guide is not signed yet: colour and type tokens, ThemeData, the supplied logo, core widgets (buttons, inputs, cards, badges, empty, error and loading states, offline banner), a widget gallery screen in the dev flavor only | NF-09 | Gallery shows every core widget, and the logo is `La Logo.png` |
| [ ] | T02.5 | Claude Code | Backend deploy workflow `deploy-backend.yml`: on merge to `dev`, apply migrations and deploy Edge Functions to the dev Supabase project; production only by manual run with a typed confirmation | — | A test migration reaches dev from a merged PR |

## Friday update to Miss Reid

The wireframes and the high-fidelity UI are approved. A signed SRS was skipped. The backend deploy is still open.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-02.md and these docs:
- docs/design/ui-design-prompt.md
- docs/04-mobile-app.md
- docs/13-ci-cd.md §3

Implement the Claude Code tasks for this week, in order: T02.4, T02.5.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-02.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
