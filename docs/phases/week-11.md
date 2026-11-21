# Week 11: Reports, quality pass and beta

**Mon 25 Jan to Fri 29 Jan 2027** · M3 Admin and Beta

**Goal:** Payout reports, accessibility, performance and security passes, release pipelines tested, beta to the client.

**End of week:** Beta builds with the client (Beta Delivery invoice, $1,896).

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T11.1 | Claude Code | `payout_summary` and `payout-report` (PDF and CSV) | BM-11 | Totals match a manual sum of seeded orders |
| [ ] | T11.2 | Claude Code | Reports screen with share or download (B-15); restaurant account screen, logout returns to the customer app as a guest (B-16) | BM-11, BM-01 | PDF opens on Android and iPhone |
| [ ] | T11.3 | Claude Code | Accessibility pass: text scaling, contrast, semantics labels | NF-09 | Checklist in `08-testing.md` §5 passes |
| [ ] | T11.4 | Claude Code | Performance pass on dev: query plans, image sizes, cold start; load test of 200 users | NF-03, NF-04 | NF-03 targets met |
| [ ] | T11.5 | Claude Code | Security review: RLS, secrets, storage policies, rate limits, key restrictions | NF-05 | Checklist in `08-testing.md` §6 ticked |
| [ ] | T11.6 | Claude Code | App Review demo accounts: password sign-in only for allow-listed review emails (customer and restaurant) | NF-11 | Reviewers can log in without email access; others never see a password field |
| [ ] | T11.7 | Claude Code | Release pipelines dry run: tag `v0.9.0` sends a prod AAB to Play internal testing (GitHub Actions) and a prod IPA to TestFlight (Codemagic `ios-release`) | — | Both builds appear in the store consoles |
| [ ] | T11.8 | You | Beta: dev builds to the client through Firebase App Distribution and TestFlight "Save It Dev"; beta notes; decide on real restaurants joining | — | Client confirms install once a device is available; invoice sent |

## Friday update to Miss Reid

Beta is ready: install links and what to test. Invoice for Beta Delivery.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-11.md and these docs:
- docs/08-testing.md §5–6
- docs/09-release.md
- docs/13-ci-cd.md

Implement the Claude Code tasks for this week, in order: T11.1, T11.2, T11.3, T11.4, T11.5, T11.6, T11.7.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-11.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
