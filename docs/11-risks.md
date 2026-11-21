# 11. Risk register

Review this list weekly. Likelihood and impact are rated H (high), M (medium) or L (low).

| # | Risk | L | I | Mitigation | Owner |
|---|---|---|---|---|---|
| R1 | **Apple organisation account delayed.** It needs a D-U-N-S number for Arise Ltd., which can take 1–3 weeks. | M | H | Start in Week 1 (T01.2); needed by Week 4 for TestFlight. Delays extend the milestones (Agreement §3). | Client |
| R2 | **Google Play personal account.** A personal account would need 12 testers for 14 days of closed testing before production. | M | H | Require an organisation account (T01.2). If only a personal account is possible, start closed testing in Week 9. | Client |
| R3 | **Business Rules or open questions answered late** (commission basis, VAT, areas). | M | M | Defaults are already in the sheet; build with the defaults and change settings by migration later. | Client |
| R4 | **Workload.** About 444 planned hours over 12 weeks, mostly 40–45 hours a week from Week 3. | H | H | Track hours weekly against the internal hours sheet. Use the buffer tasks. Raise slippage with the client early. | Developer |
| R5 | **App Store rejection**, for example because reviewers can't log in with email codes, or over account deletion or privacy labels. | M | M | Demo accounts with password sign-in (T11.6); deletion in the app; follow the checklist in `09-release.md`. | Developer |
| R6 | **Login code emails land in spam.** | M | H | Verify the domain in Resend with SPF, DKIM and DMARC; plain-text versions; test with Gmail and Outlook in T10.6. | Developer |
| R7 | **Two customers reserve the last item at the same time.** | L | H | Row locks in `reserve_order` and the concurrency test (T07.2). | Developer |
| R8 | **Restaurants forget to set the window or post listings**, so Explore looks empty at launch. | M | M | "Repeat yesterday" makes posting quick; the Today screen prompts them; the client onboards restaurants before launch. | Client |
| R9 | **Expiry depends on pg_cron**: if the job stops, orders never expire. | L | M | Checked during maintenance; `my_orders` also treats an order as expired for display once its window has ended. | Developer |
| R10 | **Data residency.** EU hosting may need legal confirmation under UAE data protection law. | L | M | Noted in SRS NF-06; the client confirms with its legal adviser before launch. | Client |
| R11 | **Scope creep from feedback** (ratings, map, payments). | H | M | The SRS is binding; anything new is quoted as a Change Request (§6.1). See the roadmap. | Developer |
| R12 | **Late payment pauses work.** | L | M | Invoice promptly at each trigger (Agreement §4). | Developer |
| R13 | **No Mac, and no acceptance phone yet.** Android and iOS are both built. The only named client device is a Galaxy S26 Ultra, and it is not available for testing yet. | M | H | Produce the iOS build through Codemagic (T04.9) without a local Mac. Install and accept on a device when one is available. No Xcode-only setup (CLAUDE.md rule 7). | Developer |
| R14 | **Codemagic free minutes run out** (500 a month, about 30–40 iOS builds). | L | M | iOS builds only on tags or manual runs; Android builds on GitHub Actions. If it's ever short, buy minutes for that month. | Developer |
| R15 | **Apple account not ready by Week 4**, which blocks TestFlight. | M | M | Chase in the Week 1–3 Friday updates. Keep developing on Android and move T04.9 to the week the account is ready. | Client |
| R16 | **Week 12 is tight:** the client's 5-day testing window, fixes and submission all fall in the same week. | H | M | Share the beta in Week 11 so she can start testing early; triage daily; agree that minor issues can follow in the first maintenance update. | Both |
