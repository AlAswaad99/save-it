# 10. Handover and maintenance

## 1. Handover checklist (T12.6)

**Code and docs**
- [ ] The GitHub repo is transferred to the client's GitHub organisation (or the client is made owner), with the full history.
- [ ] `docs/` is up to date, including the final SRS, the signed Business Rules Sheet and the design exports.
- [ ] `CHANGELOG.md` lists v1.0.0.
- [ ] Pipeline configs are in the repo (`.github/workflows/`, `codemagic.yaml`), with a list of the secrets each one needs. The Codemagic app is either moved to a client-owned Codemagic account or left for the client to reconnect.

**Accounts and secrets.** The client owns these and the developer keeps access during maintenance.
- [ ] Supabase org: the client is owner; the developer is a member until the end of maintenance.
- [ ] Firebase, Google Cloud, Vercel and Resend: the client is owner.
- [ ] Apple Developer and Google Play: already the client's.
- [ ] The Android upload key and keystore passwords are handed over through a password manager share, not email.
- [ ] Every secret value is listed in a handover note shared through a password manager: Supabase keys, Resend key, FCM service account, hook and dispatch secrets, Google key, demo account passwords.

**Training**
- [ ] A recorded admin walkthrough of about 30 minutes: creating restaurants, address search, customers, orders, cancelling, suspending, CSV export, adding admins.
- [ ] A one-page restaurant guide (PDF): login, setting the pickup window, listings, repeating yesterday's listings, scanning, cancelling, reports.

**Sign-off:** the client confirms receipt in writing.

## 2. Maintenance period (2 months, Agreement §6.3)

| Routine | When |
|---|---|
| Check Crashlytics, Supabase logs, failed outbox rows, Resend bounces | Twice a week |
| Check Supabase usage (database size, egress) and Google Cloud billing | Weekly |
| Apply OS and store-policy updates, Flutter or package security patches | As needed |
| Small fixes within the maintenance allowance; anything bigger becomes a Change Request | As reported |
| Monthly summary email to the client (issues, fixes, usage) | End of each month |

At the end of maintenance, the developer's access is removed or kept as the client prefers, and any ongoing support is agreed separately.
