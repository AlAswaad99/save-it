# 09. Release

## 1. Build and distribute

Builds come from pipelines, never from your PC. iOS can't be built on Windows. Details are in [13-ci-cd.md](13-ci-cd.md).

| | Android | iOS |
|---|---|---|
| Dev builds | `android.yml` on every merge to `main` → Firebase App Distribution | Codemagic `ios-dev`, started manually → TestFlight app "Save it Dev" |
| Release builds | `android.yml` on tag `v*` → Play internal testing track | Codemagic `ios-release` on tag `v*` → TestFlight on the real app |
| Signing | Upload key created on your PC, stored in GitHub secrets (base64) and in a password manager; Play App Signing enabled | Codemagic automatic signing using the client's App Store Connect API key |
| First upload | Once, **by hand** in Play Console (T04.8), because Google needs one manual upload before the API can publish | Automatic |
| Crash symbols | Crashlytics Gradle plugin in the release build | dSYM upload step in `codemagic.yaml` |

Before tagging a release, increase the `BUILD` number in `pubspec.yaml` and update `CHANGELOG.md`. Promoting a build from internal testing to production (Play) and submitting for review (App Store) are done by hand in the consoles.

## 2. Production cutover checklist (T12.3)

**Supabase (prod, Pro plan, Frankfurt)**
- [ ] Migrations and functions applied with a manual run of `deploy-backend.yml` (target `prod`); `app_settings` values checked against the signed Business Rules Sheet.
- [ ] Areas, categories and tags seeded; no sample data.
- [ ] Auth settings:
  - email code length 6, expiry 600 seconds
  - inactivity timeout 30 days
  - Send Email Hook pointing to the prod function
  - site URL set
  - new users created only through email-code sign-in (customers) or the admin functions (restaurants, admins)
- [ ] Edge Function secrets: Resend key, FCM service account, hook secret, dispatch secret.
- [ ] pg_cron jobs scheduled; pg_net reaches the `dispatch` URL.
- [ ] Storage buckets and policies are present.
- [ ] The first admin account is created; its password is handed to the client.

**Other services**
- [ ] Firebase prod: APNs key uploaded; Crashlytics enabled; the analytics data-collection flag turned off.
- [ ] Resend: production domain verified (SPF, DKIM, DMARC); a test email reaches Gmail's inbox, not spam.
- [ ] Vercel production: environment variables set, `production` branch created, custom domain and HTTPS working.
- [ ] Google Cloud: the Places key is restricted to the Places API (New); the quota cap and a $10 budget alert are set.

**Final check:** run the end-to-end checklist (`08-testing.md` §4) against prod using a test restaurant, then deactivate it.

## 3. App Store checklist (iOS)

- [ ] The app record is created under the client's organisation account with name Q-05, bundle ID, primary language English, and category Food & Drink.
- [ ] Description, keywords, support URL and privacy policy URL (Q-06, BR-18).
- [ ] Screenshots: 6.9" and 6.5" iPhone sizes, showing Explore, Restaurant, Basket, Pickup pass and Business mode.
- [ ] App Privacy answers:
  - **Collected and linked to the user:** name, email, phone, precise location (used only in the app, not stored), crash data.
  - **Not collected:** tracking, advertising data.
- [ ] Sign-in information for App Review: the customer and restaurant demo accounts (T11.6), plus a note explaining Business mode.
- [ ] Account deletion is reachable in the app (Profile → Delete account).
- [ ] Export compliance: uses only standard encryption (HTTPS), so it is exempt.
- [ ] Age rating questionnaire completed.

## 4. Google Play checklist (Android)

- [ ] The app is created under the client's **organisation** developer account. A personal account would need 14 days of closed testing with 12 testers before production, which doesn't fit the timeline.
- [ ] Store listing: name, short and full description, feature graphic, phone screenshots.
- [ ] Data safety form, matching the App Privacy answers; the account deletion URL is given (a web page or support email process, as Google requires).
- [ ] Content rating questionnaire, target audience (18+ or general), and an ads declaration (no ads).
- [ ] Permissions declarations: location (while in use), camera, notifications.
- [ ] Release to production, either a staged rollout (20% for 1–2 days, then 100%) or full rollout if the client prefers.

## 5. After submission

- Release manually on the same day once both apps are approved (soft launch). Watch the review status every day and fix any rejection the same day where possible. Store review time does not count against the timeline (Agreement §3).
- Once approved: confirm with the client before releasing manually, then update `CHANGELOG.md` and tag `v1.0.0`.
