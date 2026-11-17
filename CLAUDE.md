# Save it: guide for AI coding assistants

Save it lets restaurants in Abu Dhabi sell end-of-day surplus food at a discount. Customers reserve items in the app and pay at the counter when they collect them with a pickup code. The client is Arise Ltd. and the developer is Daniel Terefe.

## Source of truth

- **Scope:** the signed SRS and the wireframes (`docs/srs/`) define the scope. Do not build anything that is not in them. The "Out of scope" section in the SRS and `docs/12-roadmap.md` list features that are deliberately excluded.
- **Plan:** one plan file per week in `docs/phases/week-NN.md`. Work one task ID at a time (for example `T07.1`), and treat its "Done when" line as the acceptance test. Tasks marked "You" are for Daniel, not for you.
- **Business values:** values such as commission, minimum discount and limits come from the `app_settings` table, which is seeded from the signed Business Rules Sheet. Never hard-code them.

## Repo layout

```
app/          Flutter app (customer + restaurant Business mode, one codebase)
admin/        Next.js admin web app (shadcn/ui), deployed on Vercel
supabase/     migrations/, functions/ (Edge Functions, Deno), seed.sql, tests/ (pgTAP)
.github/      workflows: ci.yml, deploy-backend.yml, android.yml
codemagic.yaml  iOS builds (ios-dev, ios-release)
docs/         technical plan (start at docs/README.md)
```

## Environments

There are two hosted Supabase projects, **dev** and **prod**, and no local Supabase stack on the developer's PC. The developer works on Windows with an Android phone, so iOS builds only happen on Codemagic.

| | dev | prod |
|---|---|---|
| Supabase | `saveit-dev` (free org) | `saveit-prod` (client's Pro org) |
| Firebase | `saveit-dev` | `saveit-prod` |
| App flavor | `dev` | `prod` |
| Distribution | Firebase App Distribution (Android), TestFlight "Save it Dev" (iOS) | Google Play, App Store |
| Admin | Vercel deployment from `main` | Vercel production (custom domain) |

CI runs the database tests on a temporary Supabase stack inside the GitHub runner, never against dev or prod.

## Stack

- **App:** Flutter, Riverpod (with code generation), go_router, freezed and json_serializable, supabase_flutter.
- **Backend:** Supabase (EU, Frankfurt): Postgres with PostGIS, row-level security, pg_cron and pg_net, Auth (email OTP), Storage and Edge Functions.
- **Admin:** Next.js App Router, TypeScript, shadcn/ui, @supabase/ssr.
- **Push:** Firebase Cloud Messaging.
- **Crashes:** Firebase Crashlytics. There is no usage analytics, by design.
- **Email:** Resend.
- **Address search:** Google Places API (New), admin only, called through a server route.

## Commands (Windows PowerShell or Git Bash)

```
# backend (no Docker needed)
supabase migration new <name>
supabase db push                          # apply migrations to the linked dev project
supabase functions deploy <name> --use-api
# Database tests run in CI (ci.yml); push a branch to run them.

# app
cd app
flutter run --flavor dev --dart-define-from-file=env/dev.json
flutter analyze; flutter test
dart run build_runner build --delete-conflicting-outputs

# admin
cd admin; pnpm dev
pnpm lint; pnpm typecheck
```

## Rules

1. **Business logic in the database:**
   - Any change to stock, orders or status goes through a Postgres function, called as an RPC: `reserve_order`, `confirm_pickup`, `cancel_order`, `set_pickup_window` and so on. Clients never update `orders` or the `listings.quantity_reserved` column directly.
   - Security-definer functions must check the caller's role first.
2. **Row-level security:** every new table gets RLS policies and a pgTAP test in the same pull request.
3. **Time:** store every timestamp as `timestamptz`. "Today" is calculated in `Asia/Dubai` using `app_today()`. Never use the device clock for business rules.
4. **Money:** use `numeric(10,2)` in AED. Copy prices and the commission rate onto the order when it is created.
5. **Errors:** RPCs raise errors with a stable code (`SI001`, ...; see `docs/03-backend-api.md`). The app maps codes to messages in one place.
6. **Text:** all user-facing strings go through `app/lib/l10n/app_en.arb`, in English only for now, so Arabic can be added later.
7. **iOS without a Mac:** never rely on Xcode-only steps.
   - iOS has one target. The bundle ID and display name are set by `codemagic.yaml` at build time.
   - Do not add iOS schemes, and do not pass `--flavor` for iOS builds. Dart reads the flavor from `--dart-define-from-file`.
   - Initialise Firebase in Dart with `firebase_options_dev.dart` or `firebase_options_prod.dart`, chosen by `FLAVOR`.
   - Edit `Info.plist`, entitlements and `project.pbxproj` as text, carefully. Follow `docs/13-ci-cd.md` §4.
8. **Commits:** reference the task ID and SRS IDs, for example `T07.1 reserve_order RPC (CA-11, SR-07)`.
9. **Out of scope:** do not add analytics SDKs, payment SDKs, maps SDKs or any feature listed as out of scope.
