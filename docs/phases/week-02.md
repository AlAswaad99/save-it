# Week 2: UI design and SRS sign-off

**Mon 23 Nov to Fri 27 Nov 2026** · M1 Discovery and Design

**Goal:** Approved UI designs, signed SRS v1.0 with the Business Rules, and the app theme in code. Also, backend deployment automated.

**End of week:** Signed SRS v1.0 and Business Rules; approved designs exported to `docs/design/`; theme and core widgets in the app.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T02.1 | You | UI design in Claude Design from `docs/design/ui-design-prompt.md`: style guide, then all customer, Business mode and admin screens | All | Every wireframe screen has a designed version; style guide is one page |
| [ ] | T02.2 | You | Check the designs against the SRS and wireframes; client design review; fixes; written approval | — | Client approval email saved; exports in `docs/design/` |
| [ ] | T02.3 | You | Issue SRS v1.0 from the answers already recorded in `docs/srs/decisions.md`, and both sign. The numeric rules and the screen copy are in; terms and the privacy policy are not | All | Signed SRS in `docs/srs/`; open questions in `decisions.md` answered or explicitly deferred |
| [x] | T02.4 | Claude Code | Flutter theme from the approved style guide, or from the brand files in `docs/businessrules-and-contents/` if the style guide is not signed yet: colour and type tokens, ThemeData, the supplied logo, core widgets (buttons, inputs, cards, badges, empty, error and loading states, offline banner), a widget gallery screen in the dev flavor only | NF-09 | Gallery shows every core widget, and the logo is `La Logo.png` |
| [ ] | T02.5 | Claude Code | Backend deploy workflow `deploy-backend.yml`: on merge to `main`, apply migrations and deploy Edge Functions to dev; production only by manual run with a typed confirmation | — | A test migration reaches dev from a merged PR |

## Friday update to Miss Reid

Designs for review (Mon/Tue), approval request, SRS v1.0 for signature. Milestone 1 complete once both are signed.

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
