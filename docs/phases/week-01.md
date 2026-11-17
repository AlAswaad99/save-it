# Week 1: Project setup

**Mon 16 Nov to Fri 20 Nov 2026** · M1 Discovery and Design

**Goal:** Requirements sent for review, client accounts started, and every project (repo, app, backend, admin, Firebase, CI) running so building can start immediately.

**End of week:** Empty but working app (Android dev build on your phone), linked dev Supabase project, admin skeleton on a Vercel preview, CI green.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [x] | T01.1 | You | Send SRS v0.3, wireframes and the Business Rules sheet for review | All | Sent on 17 Nov; comments and the sheet due by about 24 Nov |
| [ ] | T01.2 | You | Client accounts checklist: Apple Developer (organisation, D-U-N-S), Google Play (organisation), Supabase (prod org on Pro; dev project in a free org), Firebase, Google Cloud billing, Resend, Vercel, domain DNS. Agree the bundle ID prefix | §5 Agreement | Each account is active with you invited, or listed in `11-risks.md` with a date. Apple account is needed by Week 4 |
| [ ] | T01.3 | You | Create the GitHub repo: monorepo layout, `CLAUDE.md`, `docs/`, `.gitignore`, branch protection on `main` | — | Repo pushed; `main` protected |
| [x] | T01.4 | Claude Code | Flutter project: Android productFlavors `dev` and `prod`; one iOS target (bundle ID, name and Firebase file set at build time, see `13-ci-cd.md` §4); `env/*.json`; feature folders; lints; Riverpod + go_router skeleton with placeholder tabs; gen-l10n with `app_en.arb` | NF-01, CA-18 | `flutter run --flavor dev` works on your Android phone; `flutter analyze` is clean |
| [ ] | T01.5 | You | Create the Supabase dev project (Frankfurt, free org); install the CLI on Windows; `supabase link`; enable extensions (postgis, pg_cron, pg_net, pg_trgm); add the secrets to GitHub | NF-06 | `supabase db push` of an empty migration succeeds from your PC |
| [ ] | T01.6 | You | Firebase projects `saveit-dev` and `saveit-prod`: Android and iOS apps for both bundle IDs; Crashlytics wired up in the app | NF-08 | A test crash from the Android dev build appears in Crashlytics |
| [x] | T01.7 | Claude Code | Next.js admin skeleton: shadcn/ui, @supabase/ssr clients, middleware stub. Connect the Vercel project to GitHub (previews on PRs, `main` pointing at dev) | NF-02 | Preview URL loads the login page |
| [x] | T01.8 | Claude Code | CI checks workflow `ci.yml`: Flutter analyze and test, admin lint and typecheck, database tests on a temporary Supabase stack inside the runner | — | All three jobs pass on a test PR |

## Friday update to Miss Reid

SRS, wireframes and Business Rules sent; accounts checklist shared with dates; projects set up.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-01.md and these docs:
- CLAUDE.md
- docs/01-architecture.md
- docs/04-mobile-app.md §1–3
- docs/13-ci-cd.md §1–2

Implement the Claude Code tasks for this week, in order: T01.4, T01.7, T01.8.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-01.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
