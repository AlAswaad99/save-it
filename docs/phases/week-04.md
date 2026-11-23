# Week 4: App shell, sign-in and first store builds

**Mon 7 Dec to Fri 11 Dec 2026** · M2 Core Build

**Goal:** Customers can open the app, go through the walkthrough, choose a location and sign in. First builds reach both stores' test channels.

**End of week:** Android dev build via Firebase App Distribution; iOS dev build on TestFlight checked on your friend's iPhone; first prod AAB uploaded to Play internal testing.

## Tasks

| Done | ID | Who | Task | SRS | Done when |
|---|---|---|---|---|---|
| [x] | T04.1 | Claude Code | App shell: bottom tabs, router with guest/customer/restaurant redirects, splash (C-01) | CA-01 | Redirect rules from `04-mobile-app.md` §4 covered by router tests |
| [x] | T04.2 | Claude Code | Welcome walkthrough, 3 slides, first launch only, Skip and Get started (C-29), using the copy and the three illustrations in `04-mobile-app.md` | CA-19 | Shown once; the three supplied sentences and images are on the slides; Skip or Get started opens the location sheet |
| [x] | T04.3 | Claude Code | Location sheet over Explore, GPS with timeout, area picker, saved origin (C-02, C-03) | CA-02 | Denying location leads to the area picker; the origin is kept after restart |
| [x] | T04.4 | Claude Code | Email-first sign-in: sign-in gate (C-12), Continue with email (C-14), code entry with auto-submit and resend limit (C-15), Complete your profile for new emails (C-13) using `complete_profile`; return to where the customer started | CA-01, CA-03, CA-04 | New and returning emails follow the right path; wrong, expired and rate-limited codes show the right message |
| [x] | T04.5 | Claude Code | Session persistence, logout (clears device token), guest prompts on Orders and Profile (C-20 guest, C-22 guest) | CA-01, CA-04 | After logout the app is in the guest state and the basket is kept |
| [x] | T04.6 | Claude Code | Profile, edit profile (email read-only), legal links and support email (C-22, C-23) | CA-05, NF-11 | Name and phone update; links open |
| [ ] | T04.7 | Claude Code | Android pipeline `android.yml`: dev APK to Firebase App Distribution on merge to `main`; prod AAB signed with the upload key on tag | — | A merge puts a new dev build on your phone automatically |
| [ ] | T04.8 | You | First prod AAB uploaded by hand to Play internal testing; Play API service account created for the pipeline | — | Play Console shows the internal release; service account has release access |
| [ ] | T04.9 | You | Codemagic: connect the repo, App Store Connect API key, "Save It Dev" app record; run `ios-dev` to TestFlight | NF-01 | The iOS dev build is produced. On-device install waits until a phone is available |
| [ ] | T04.10 | Claude Code | Business mode entry from Profile, restaurant login (no self sign-up, role check), terms acceptance (B-01, B-02) | BM-01 | A customer email cannot enter Business mode; first login forces the terms |

## Friday update to Miss Reid

Sign-in and onboarding working; first iPhone and Android test builds out.

## Claude Code prompt

```
Read CLAUDE.md, then docs/phases/week-04.md and these docs:
- docs/04-mobile-app.md
- docs/03-backend-api.md §2–3
- docs/13-ci-cd.md §4–5

Implement the Claude Code tasks for this week, in order: T04.1, T04.2, T04.3, T04.4, T04.5, T04.6, T04.7, T04.10.
Skip tasks marked "You"; if one of my tasks blocks yours (for example an account or key isn't ready), stop and tell me what you need.

For each task:
1. Restate the task, its SRS IDs and its "Done when" check in one or two lines, and list the files you will touch.
2. Implement it following CLAUDE.md and the reference docs. Business values come from app_settings; database changes are new migrations; every new table, policy or RPC gets pgTAP tests.
3. Run the checks that apply (flutter analyze, flutter test, pnpm lint, pnpm typecheck; database tests run in CI) and fix failures.
4. If the change alters a table, RPC, route or notification, update the matching doc in docs/.
5. Tick the task in docs/phases/week-04.md and commit with "<task ID> <summary> (<SRS IDs>)".

Do not add anything outside the SRS. If a requirement is unclear or the docs conflict, stop and ask me before guessing.
At the end, give me a short summary: tasks done, anything left open, and anything I need to check on a real device.
```
