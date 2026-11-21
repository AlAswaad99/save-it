# 07. Conventions

## 1. Branching and commits

- `dev`, `prod`, and `main` are protected. A merge into `dev` that changes `supabase/` deploys migrations and Edge Functions to the dev Supabase project. Production deploys only when someone starts `deploy-backend.yml` and types `DEPLOY PROD`. Admin and Android builds follow [13-ci-cd.md](13-ci-cd.md).
- Branches are named `t07-1-reserve-order`, `fix/scan-torch` or `cr-01-ratings`, and live a few days at most.
- Commits start with the task ID and list the SRS IDs: `T07.1 reserve_order RPC (CA-11, SR-07)`.
- Squash-merge pull requests. The PR description links the task, lists what changed, and includes screenshots for UI work.
- Releases are tagged `v1.0.0`, `v1.0.1` and so on.

## 2. Versioning

- **App:** `version: MAJOR.MINOR.PATCH+BUILD` in `pubspec.yaml`. `BUILD` increases on every store upload. Launch is 1.0.0.
- **Database:** the migration file names are the version history. Never edit a migration that has already been applied to dev or prod; add a new one instead.
- **Documents:** the SRS version follows its Document Control table, and this plan's version is in `docs/README.md`.

## 3. Code style

| Area | Rules |
|---|---|
| Dart | `flutter_lints` with the strict analyzer settings; `dart format`; no `print` (use `log` or Crashlytics); every screen reads data through a controller, never through Supabase directly |
| SQL | lower-case keywords, `snake_case`, one object per migration where practical; functions declare `security definer set search_path = public` and check the role on their first line |
| TypeScript | `strict` mode, ESLint plus Prettier, server components by default, `"use client"` only where needed |
| Edge Functions | shared helpers in `functions/_shared/`; validate input; return JSON `{error: {code, message}}` on failure |
| Naming | screens `XxxScreen`, controllers `XxxController`, repositories `XxxRepository`; RPCs named verb-first (`reserve_order`) |
| Strings | all user-facing text in `app_en.arb`; no string concatenation for sentences (use placeholders) |

## 4. Definition of done (every task)

- [ ] It meets the task's "Done when" line and the acceptance criteria of the linked SRS IDs.
- [ ] Tests are added or updated: pgTAP for any SQL change, unit or widget tests for controllers and core screens.
- [ ] `flutter analyze`, `flutter test`, `supabase test db`, and admin lint and typecheck all pass in CI.
- [ ] No hard-coded business values; they are read from `app_settings`.
- [ ] Loading, empty and error states are handled on any new screen.
- [ ] Docs are updated if a table, RPC, route or notification changed.
- [ ] It is deployed to dev and checked on your Android phone, if it affects the app. iOS-specific changes (permissions, push, camera) are also checked on the next TestFlight dev build.
- [ ] The task is ticked in its phase file.

## 5. CI and deployment

See [13-ci-cd.md](13-ci-cd.md) for every workflow. In short:
- `ci.yml` runs the checks on every pull request.
- `deploy-backend.yml` applies migrations and deploys Edge Functions to the dev project on merge into `dev`, and to production only after a typed confirmation.
- `android.yml` handles Android builds.
- Codemagic handles iOS.
- Vercel deploys the admin.
