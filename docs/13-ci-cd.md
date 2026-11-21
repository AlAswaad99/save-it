# 13. CI/CD pipelines

These pipelines are the developer's own tooling. They let a Windows PC with an Android phone build and ship both apps. They are not a client deliverable (automated build pipelines are outside the Lean Package), but the config files stay in the repo at handover.

| What | Tool | Trigger | Target |
|---|---|---|---|
| Checks (app, admin, database tests) | GitHub Actions `ci.yml` | Every PR and every push to `main` | — |
| Database migrations and Edge Functions | GitHub Actions `deploy-backend.yml` | Merge to `main` (changes in `supabase/`) → dev. Manual run with confirmation → prod | Supabase dev / prod |
| Android dev build | GitHub Actions `android.yml` | Merge to `main` (changes in `app/`) | Firebase App Distribution |
| Android release build | GitHub Actions `android.yml` | Tag `v*` | Google Play internal testing |
| iOS dev build | Codemagic `ios-dev` | Manual start | TestFlight "Save It Dev" |
| iOS release build | Codemagic `ios-release` | Tag `v*` | TestFlight on the real app |
| Admin web | Vercel GitHub integration | PR → preview; `main` → dev; `production` branch → production | Vercel |

Promotion to production in Play Console and "Submit for review" in App Store Connect stay manual.

## 1. Secrets

GitHub Environments aren't available for private repos on the free plan, so secrets are repo secrets with `DEV_` and `PROD_` prefixes.

| Secret (GitHub) | Used by | How to get it |
|---|---|---|
| `SUPABASE_ACCESS_TOKEN` | deploy-backend | Supabase account → Access tokens (an account with access to both orgs) |
| `DEV_SUPABASE_REF`, `PROD_SUPABASE_REF` | deploy-backend | Project settings → Reference ID |
| `DEV_SUPABASE_DB_PASSWORD`, `PROD_SUPABASE_DB_PASSWORD` | deploy-backend | Set when creating each project |
| `APP_ENV_DEV`, `APP_ENV_PROD` | android | Contents of `app/env/dev.json` and `app/env/prod.json` |
| `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD` | android | Upload keystore made once with `keytool` on your PC; base64-encode it (`certutil -encode` on Windows). Keep the original in a password manager. |
| `FIREBASE_ANDROID_DEV_APP_ID`, `FIREBASE_DIST_SA` | android | Firebase dev project → app ID; a service account with the "Firebase App Distribution Admin" role |
| `PLAY_SA_JSON` | android | Google Cloud service account, invited in Play Console with release permissions (T04.8) |

Codemagic keeps its own secrets in environment variable groups: `saveit_dev` and `saveit_prod`, each holding `APP_ENV_JSON`. The App Store Connect API key is added once under **Integrations** in your personal Codemagic account. The client creates the key in App Store Connect (Users and Access → Integrations, App Manager role) and sends you the `.p8` file, key ID and issuer ID.

## 2. `ci.yml`: checks

```yaml
name: CI
on:
  pull_request:
  push:
    branches: [main]

jobs:
  app:
    runs-on: ubuntu-latest
    defaults: { run: { working-directory: app } }
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { channel: stable, cache: true }
      - run: flutter pub get
      - run: dart run build_runner build --delete-conflicting-outputs
      - run: flutter analyze
      - run: flutter test

  admin:
    runs-on: ubuntu-latest
    defaults: { run: { working-directory: admin } }
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v4
      - uses: actions/setup-node@v4
        with: { node-version: 22, cache: pnpm, cache-dependency-path: admin/pnpm-lock.yaml }
      - run: pnpm install --frozen-lockfile
      - run: pnpm lint
      - run: pnpm typecheck

  db:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: supabase/setup-cli@v1
        with: { version: latest }
      - run: supabase db start        # temporary Postgres in the runner, migrations applied
      - run: supabase test db         # pgTAP tests in supabase/tests
```

Docker exists on GitHub's Ubuntu runners, so the database tests run there even though your PC never runs a local stack.

## 3. `deploy-backend.yml`: migrations and functions

```yaml
name: Deploy backend
on:
  push:
    branches: [main]
    paths: ['supabase/**']
  workflow_dispatch:
    inputs:
      target: { type: choice, options: [dev, prod], default: dev }
      confirm: { description: 'Type DEPLOY PROD to deploy to production', required: false }

concurrency: deploy-backend

jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      SUPABASE_ACCESS_TOKEN: ${{ secrets.SUPABASE_ACCESS_TOKEN }}
    steps:
      - uses: actions/checkout@v4
      - uses: supabase/setup-cli@v1
        with: { version: latest }
      - name: Choose target
        id: t
        run: |
          T="${{ github.event.inputs.target || 'dev' }}"
          if [ "$T" = "prod" ] && [ "${{ github.event.inputs.confirm }}" != "DEPLOY PROD" ]; then
            echo "Production deploy needs the confirmation text."; exit 1
          fi
          echo "target=$T" >> "$GITHUB_OUTPUT"
      - name: Link project
        run: |
          if [ "${{ steps.t.outputs.target }}" = "prod" ]; then
            supabase link --project-ref "${{ secrets.PROD_SUPABASE_REF }}" -p "${{ secrets.PROD_SUPABASE_DB_PASSWORD }}"
          else
            supabase link --project-ref "${{ secrets.DEV_SUPABASE_REF }}" -p "${{ secrets.DEV_SUPABASE_DB_PASSWORD }}"
          fi
      - run: supabase db push
      - run: supabase functions deploy --use-api   # deploys every function in supabase/functions
```

Edge Function secrets (Resend key, FCM service account, hook and dispatch secrets) are set once per project with `supabase secrets set`, not in this workflow. Auth settings (code length, expiry, Send Email Hook, session timeout) are set in the dashboard, following `09-release.md` §2.

## 4. iOS without a Mac: project setup rules

The constraints:
- Xcode can't run on Windows.
- Flutter's iOS `--flavor` needs Xcode schemes.

So the iOS project stays as Flutter creates it, with these rules:

1. **One iOS target, no schemes.** `codemagic.yaml` sets the bundle ID (`PRODUCT_BUNDLE_IDENTIFIER`, skipping the RunnerTests lines) and the display name (`CFBundleDisplayName`) before each build.
2. **Firebase is initialised in Dart.** Use `firebase_options_dev.dart` and `firebase_options_prod.dart`, generated with `flutterfire configure` on Windows, and pick one by `FLAVOR`. No `GoogleService-Info.plist` needs to be inside the Xcode project. Copies live in `app/ios/config/{dev,prod}/`, used only to upload Crashlytics symbols.
3. **Permissions and capabilities by text edits.** These are plain text and can be edited on Windows:
   - Usage strings in `Info.plist` for location, camera and photo library.
   - `UIBackgroundModes: remote-notification` in `Info.plist`.
   - A `Runner.entitlements` file with `aps-environment = production`, referenced by `CODE_SIGN_ENTITLEMENTS` in `project.pbxproj`.
4. **App IDs.** In the Apple Developer website (no Mac needed), create `<prefix>.saveit` and `<prefix>.saveit.dev` with **Push Notifications** enabled, and create an App Store Connect app record for each. Then add the APNs key (`.p8`) to both Firebase projects.
5. **Check every iOS-sensitive change on the next `ios-dev` TestFlight build**, on your friend's iPhone. This covers permissions, push, camera, deep links and anything touching `ios/`.

## 5. `android.yml`: Android dev and release builds

```yaml
name: Android
on:
  push:
    branches: [main]
    paths: ['app/**']
    tags: ['v*']
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    defaults: { run: { working-directory: app } }
    env:
      APP_ENV_DEV: ${{ secrets.APP_ENV_DEV }}
      APP_ENV_PROD: ${{ secrets.APP_ENV_PROD }}
      KEYSTORE_B64: ${{ secrets.ANDROID_KEYSTORE_BASE64 }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with: { distribution: zulu, java-version: '17' }
      - uses: subosito/flutter-action@v2
        with: { channel: stable, cache: true }
      - name: Write env and signing files
        run: |
          printf '%s' "$APP_ENV_DEV"  > env/dev.json
          printf '%s' "$APP_ENV_PROD" > env/prod.json
          printf '%s' "$KEYSTORE_B64" | base64 -d > android/app/upload-keystore.jks
          cat > android/key.properties <<EOF
          storeFile=upload-keystore.jks
          storePassword=${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
          keyAlias=${{ secrets.ANDROID_KEY_ALIAS }}
          keyPassword=${{ secrets.ANDROID_KEY_PASSWORD }}
          EOF
      - run: flutter pub get && dart run build_runner build --delete-conflicting-outputs

      # Dev build on every merge to main
      - name: Build dev APK
        if: github.ref_type != 'tag'
        run: flutter build apk --flavor dev --dart-define-from-file=env/dev.json --build-number=${{ github.run_number }}
      - name: Send to Firebase App Distribution
        if: github.ref_type != 'tag'
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_ANDROID_DEV_APP_ID }}
          serviceCredentialsFileContent: ${{ secrets.FIREBASE_DIST_SA }}
          groups: testers
          file: app/build/app/outputs/flutter-apk/app-dev-release.apk

      # Release build on tags
      - name: Build prod app bundle
        if: github.ref_type == 'tag'
        run: flutter build appbundle --flavor prod --dart-define-from-file=env/prod.json
      - name: Upload to Play internal testing
        if: github.ref_type == 'tag'
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.PLAY_SA_JSON }}
          packageName: <prefix>.saveit
          releaseFiles: app/build/app/outputs/bundle/prodRelease/app-prod-release.aab
          track: internal
          status: completed
```

- **Signing setup:** `android/app/build.gradle` reads `key.properties` for the release signing config. `key.properties` and `*.jks` are git-ignored.
- **First upload:** the very first prod AAB is uploaded by hand in Play Console (T04.8). After that the pipeline can publish.
- **Version numbers:** dev builds use the run number as the build number. Release builds use `pubspec.yaml`.

## 6. `codemagic.yaml`: iOS builds

```yaml
workflows:
  ios-dev:
    name: iOS dev to TestFlight (Save It Dev)
    instance_type: mac_mini_m2
    max_build_duration: 40
    integrations:
      app_store_connect: SaveIt ASC Key          # name of the API key in Codemagic Integrations
    environment:
      flutter: stable
      xcode: latest
      groups: [saveit_dev]                     # APP_ENV_JSON
      vars:
        FLAVOR: dev
        BUNDLE_ID: <prefix>.saveit.dev
        APP_NAME: Save It Dev
        APP_STORE_APPLE_ID: "0000000000"       # Apple ID of the "Save It Dev" app record
      ios_signing:
        distribution_type: app_store
        bundle_identifier: <prefix>.saveit.dev
    # no "triggering" section: started manually from Codemagic
    scripts: &ios_scripts
      - name: Env file
        script: printf '%s' "$APP_ENV_JSON" > app/env/$FLAVOR.json
      - name: Bundle ID and display name
        script: |
          cd app/ios
          sed -i '' "/RunnerTests/! s/PRODUCT_BUNDLE_IDENTIFIER = .*;/PRODUCT_BUNDLE_IDENTIFIER = $BUNDLE_ID;/" Runner.xcodeproj/project.pbxproj
          /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $APP_NAME" Runner/Info.plist
      - name: Signing profiles
        script: xcode-project use-profiles
      - name: Dependencies
        script: cd app && flutter pub get && dart run build_runner build --delete-conflicting-outputs
      - name: Build IPA
        script: |
          cd app
          LATEST=$(app-store-connect get-latest-testflight-build-number "$APP_STORE_APPLE_ID" || echo 0)
          flutter build ipa --release \
            --dart-define-from-file=env/$FLAVOR.json \
            --build-number=$((LATEST + 1)) \
            --export-options-plist=/Users/builder/export_options.plist
      - name: Upload Crashlytics symbols
        script: |
          cd app
          find build/ios/archive/Runner.xcarchive -name "*.dSYM" -print0 | \
            xargs -0 -I {} ios/Pods/FirebaseCrashlytics/upload-symbols -gsp ios/config/$FLAVOR/GoogleService-Info.plist -p ios {}
    artifacts:
      - app/build/ios/ipa/*.ipa
    publishing: &ios_publishing
      app_store_connect:
        auth: integration
        submit_to_testflight: true

  ios-release:
    name: iOS release to TestFlight (Save It)
    instance_type: mac_mini_m2
    max_build_duration: 40
    integrations:
      app_store_connect: SaveIt ASC Key
    environment:
      flutter: stable
      xcode: latest
      groups: [saveit_prod]
      vars:
        FLAVOR: prod
        BUNDLE_ID: <prefix>.saveit
        APP_NAME: Save It
        APP_STORE_APPLE_ID: "0000000000"       # Apple ID of the real app record
      ios_signing:
        distribution_type: app_store
        bundle_identifier: <prefix>.saveit
    triggering:
      events: [tag]
      tag_patterns:
        - pattern: 'v*'
    scripts: *ios_scripts
    artifacts:
      - app/build/ios/ipa/*.ipa
    publishing: *ios_publishing
```

- **Account:** a personal Codemagic account, which gets 500 free macOS M2 minutes a month. The free minutes don't apply inside a Codemagic Team, so stay on the personal account.
- **Build time:** one iOS build takes about 10–15 minutes, so the free tier covers about 30–40 builds a month.
- **First run:** run `ios-dev` by hand (T04.9). If signing fails, check that the App ID exists with Push Notifications enabled, and that the API key has the App Manager role.
- **TestFlight:** testers are added in App Store Connect. Use internal testers (you, your friend, Miss Reid) for the dev app. External testing needs a short Beta App Review.

## 7. Vercel: admin web

- **Project:** import `admin/` as the project root, using the GitHub integration. No workflow file is needed.
- **Production branch:** set it to `production` in Vercel's Git settings. `main` then makes Preview deployments; give the `main` branch a fixed domain (for example `saveit-admin-dev.vercel.app`) so dev has a stable URL.
- **Environment variables:**
  - Preview uses dev Supabase and the dev Places key restrictions.
  - Production uses prod Supabase.
- **Releasing the admin:** fast-forward `production` to the release tag (`git push origin v1.0.0^{commit}:production`). Vercel deploys it.
- **Custom domain:** added to the production deployment once Miss Reid picks it (Week 12).
- **Plan:** Vercel's Hobby plan is for non-commercial use. Production should run on the client's Vercel Pro account, which is already among the resources in the quote.
