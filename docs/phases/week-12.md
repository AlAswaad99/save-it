# Week 12: Client testing, production and store submission

**Mon 1 Feb to Fri 5 Feb 2027** · M4 Testing and Launch

**Goal:** Client acceptance testing, fixes, production setup, store submission, admin deployment and handover.

**End of week:** Both apps submitted, admin live on production, handover done (Launch Submission invoice, $1,422).

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [ ] | T12.1 | You | Support the client testing round; triage issues by SRS ID (defect or Change Request) | Appendix A | Every issue classified with an owner |
| [ ] | T12.2 | Claude Code | Defect fixes and re-test | All | Appendix A all Pass, or deviations agreed in writing |
| [ ] | T12.3 | You | Production: Supabase Pro project (Frankfurt) via the manual deploy run, settings, secrets, cron jobs, auth; Firebase prod; Resend domain; Vercel production with the custom domain; Places key restrictions | NF-06, NF-07 | Production checklist in `09-release.md` §2 ticked |
| [ ] | T12.4 | You | Store listings: name, description, screenshots, privacy policy URL, App Privacy, Data safety, content rating, permissions | NF-11 | No warnings in either console |
| [ ] | T12.5 | You | Tag `v1.0.0`: pipelines upload prod builds; submit both for review; release manually on the same day after approval (soft launch) | NF-11 | Both submitted; invoice sent |
| [ ] | T12.6 | You | Handover: repo transfer, credentials, pipeline configs, docs, recorded admin training | §7.1 Agreement | Handover checklist signed off |
| [ ] | T12.7 | You | Start maintenance: monitoring, issue channel, first maintenance invoice | §6.3 Agreement | Client knows how to report issues; alerts reach you |

## Friday update to Miss Reid

Testing round results, submission status, handover. Invoice for Launch Submission; maintenance starts.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-12.md and these docs:
- docs/09-release.md
- docs/10-handover.md
- docs/13-ci-cd.md

Implement the Claude Code tasks for this week, in order: T12.2.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-12.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
