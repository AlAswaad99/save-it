# Save it

Surplus food from restaurants in Abu Dhabi. Customers reserve items in the app and pay at the counter with a pickup code.

The technical plan starts at [docs/README.md](docs/README.md). Week-by-week tasks are in `docs/phases/`.

| Path | What it is |
|---|---|
| `app/` | Flutter app (customer and restaurant Business mode) |
| `admin/` | Next.js admin |
| `supabase/` | Migrations, Edge Functions, pgTAP tests |
| `docs/` | Architecture and the build plan |

The Android application id prefix is `org.arisehub` (the example in the architecture doc) until the client agrees a prefix in T01.2. Dev is `org.arisehub.saveit.dev`. Prod, and the single iOS target, is `org.arisehub.saveit`. Codemagic rewrites the iOS bundle id at build time.

```
cd app
flutter run --flavor dev --dart-define-from-file=env/dev.json
```

Copy `app/env/example.json` to `app/env/dev.json` and fill in the dev Supabase URL and anon key before that run. Firebase is added in T01.6.
