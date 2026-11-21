# Decision log

Source: `docs/businessrules-and-contents/Save it - Business Rules (1).xlsx` and `Save it- Wireframe content.docx`, received 21 November 2026. The workbook's "Your answer" column overrides the example numbers that were in the plan. On 22 November 2026 Daniel skipped a signed SRS v1.0. The client had already approved the wireframes and the high-fidelity UI. These decisions remain the rules for the build.

Question numbers below are the client's sheet, which does not use the same Q numbers as the older plan drafts.

## Accepted

| ID | Decision | What the build does |
|---|---|---|
| BR-01, Q-01 | Commission is 40% of the amount the customer pays | `commission_rate` 0.40, copied onto the order. `commission_amount` is `round(total * rate, 2)` |
| BR-02 | Minimum discount 50% | `min_discount` 0.50 |
| BR-03 | Currency AED | Unchanged |
| BR-04 | Pickup may start at 16:00 and must end by 23:30 | `pickup_earliest` 16:00, `pickup_latest` 23:30, Asia/Dubai. The sheet's "pm" on both times is ignored |
| BR-05 | 2 | `max_units_per_listing` 2. The sheet's meaning is per listing |
| BR-06 | 2 open reservations | `max_active_orders` 2 |
| BR-07 | Reminder 30 minutes before the window ends | `reminder_minutes` 30 |
| BR-08 | Warn at 2 no-shows in one week | `noshow_warn_count` 2, `noshow_warn_period_days` 7, rolling |
| BR-09 | Suspend at 3 no-shows in 30 days | `noshow_suspend_count` 3, `noshow_suspend_period_days` 30, rolling |
| BR-10 | Every suspension stays until an admin lifts it | Confirmed 21 November 2026. No automatic end after one week |
| BR-11 | Categories | Salads, Savoury Dishes, Sweet Treats, Beverages, Snacks, Bakery, Kids Menu |
| BR-12 | Dietary tags | Vegetarian, Vegan, Gluten-free, Contains nuts, Lactose-free. Halal is not included |
| BR-13 | Documents checked before a restaurant account exists | Offline checklist only. Not an admin upload feature |
| BR-14 | Restaurant fields | Name, logo, address and map pin, opening hours, manager email, manager phone. Matches the admin form already in `05-admin-web.md` |
| BR-15, BR-16 | Monthly settlement, invoice raised by hand | No new billing feature. Payout reports stay as specified. Finance contact `contact@arisehub.org` |
| BR-17, BR-18 | Arise Ltd. writes the terms and the privacy policy | Screens link out. The pages stay empty until the documents arrive |
| BR-19 | Support contact | `contact@arisehub.org` |
| Q-02 | Prices are VAT-inclusive and the app says so | `prices_include_vat` true. Show `AED 15.00 incl. VAT` |
| Q-03 | Area list | Al Hudayriyat Island and Al Khalidiya are two areas. "Al Hisin" is stored as Al Hisn. Centres are in `02-database.md` |
| Q-04 | Name "Save It" | App, stores, emails, and admin use "Save It". Dev builds are "Save It Dev" |
| Q-05 | Devices | Build Android and iOS now. On-device acceptance waits until a phone is available |
| Copy | Walkthrough, location sheet, empty list, too-early line, welcome and order-confirmed wording | `04-mobile-app.md` and `06-notifications.md` |
| Design, 22 Nov 2026 | Approved high-fidelity UI in `docs/save-it-design-handoff/` | Suspension copy has no end date. The Explore empty title is "No food near you right now". The filter chip "No nuts" hides items tagged Contains nuts. The item tag stays "Contains nuts". Halal is not a tag |
| Art | Logo and three walkthrough drawings, plus a map pin | `docs/businessrules-and-contents/`. The walkthrough pairing is slide 1 `Cycle.png`, slide 2 `La point.png`, slide 3 `La pay.png`, location `image_7e411891.jpg` |

## Still to come

- **Terms and privacy policy.** Arise Ltd. will send them. The screens can link out, and the pages stay empty until the documents arrive.
- **On-device testing.** Both platforms are built. Acceptance on a phone waits until one is available.
- **Al Marina.** No map district has that name. The seed point is Marina Mall (24.47604, 54.32143). Say if a different place was meant.
- **Area centres** are map centroids, not surveyed pins. An admin can move them.
