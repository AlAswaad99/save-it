# Save It · design handoff

High-fidelity UI for Save It (customer app, Business mode and admin dashboard), exported for development on 22 November 2026.
Source of truth: the "Save It – High-fidelity UI" design canvas. The low-fidelity wireframes and the SRS v0.2 screen IDs (C-xx, B-xx, A-xx) are used throughout.

## What's in this folder

| Folder | Contents |
|---|---|
| `screens/` | Every screen and state as its own PNG at @2x (phone screens 780 × 1688, admin 2880 × 1800, emails 1200 wide). `screens/index.json` lists them with notes. |
| `design-system/style-guide/` | Style guide, whole page and one PNG per section (colours, type, spacing, radii, elevation, icons, imagery, contrast). |
| `design-system/components/` | Component sheet, whole page and one PNG per component group. |
| `flows/` | Navigation maps for the customer app, Business mode and admin. |
| `decisions/` | The decisions log (business rules applied, your decisions, notes). |
| `flutter/` | Drop-in theme, widgets, ARB strings, fonts and image assets for the Flutter app. |
| `web-admin/` | Tokens for the React or Next.js admin: CSS variables, Tailwind config, shadcn/ui theme. |
| `tokens/tokens.json` | Every token in one neutral JSON file (W3C design-tokens style). |
| `assets/` | Logo, illustrations, Lucide icon SVGs and sample photos with credits. |

## Flutter app

Needs Flutter 3.27 or later (the theme uses `CardThemeData` and `DialogThemeData`).

1. Copy `flutter/lib/theme`, `flutter/lib/widgets` and `flutter/lib/l10n` into your `lib/`.
2. Copy `flutter/fonts` and `flutter/assets` to the project root.
3. Merge `flutter/pubspec-additions.yaml` into `pubspec.yaml` and copy `flutter/l10n.yaml` to the project root. Run `flutter pub get`.
4. Use the theme and strings:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'theme/save_it_theme.dart';

MaterialApp(
  theme: SaveItTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: ...,
);
```

| File | What it gives you |
|---|---|
| `theme/save_it_colors.dart` | `SaveItColors`: every colour token, with where it's used. |
| `theme/save_it_typography.dart` | `SaveItType`: the type scale (Titillium Web 400/600/700) and the Material `TextTheme` mapping. |
| `theme/save_it_tokens.dart` | `SaveItSpace`, `SaveItRadius`, `SaveItShadows` (e1, e2, e3) and `SaveItSizes`. |
| `theme/save_it_theme.dart` | `SaveItTheme.light`: Material 3 `ThemeData` covering buttons, fields, chips, checkboxes, radios, switches, navigation bar, sheets, dialogs, cards and snack bars. |
| `widgets/status_badge.dart` | `StatusBadge(SaveItStatus.reserved)` for all 12 order, listing and account statuses. |
| `widgets/brand_widgets.dart` | `CategoryDefaultImage`, `RestaurantMonogram`, `BusinessHeader` (dark Business mode header) and `SaveItCard`. |
| `l10n/app_en.arb` | All customer and Business mode copy (329 strings) with placeholder types, grouped by screen in each description. |

Check before you build:
- **Not compiled here.** The Dart files were written against the Flutter 3.27 API but couldn't be compiled in this export environment. Expect a quick `flutter analyze` pass.
- **Icon names.** Widgets use `lucide_icons_flutter` (`import 'package:lucide_icons_flutter/lucide_icons.dart'`). Icon names follow Lucide in camelCase (`LucideIcons.triangleAlert`, `LucideIcons.cookingPot`). If your installed version names one differently, swap it there.
- **Fonts.** The bundled TTFs are the Latin subset of Titillium Web (English, numbers, AED). For full coverage, download the complete family from Google Fonts or use the `google_fonts` package.
- **Push and email copy.** The ARB includes push titles and bodies. If notifications are sent by the backend, reuse the same strings there. Email HTML layouts are in `screens/6-emails-and-notifications/`.

Layout rules worth knowing:
- Phone frame 390 × 844. Screen margin 20. Status bar safe area 47, home indicator 34.
- Touch targets at least 44 × 44. Mobile buttons and fields are 52 tall.
- Business mode is the same app with a dark header (`BusinessHeader`) and a 5-item navigation bar (Today, Listings, Scan, Orders, Reports). Scan is a 60 px vine circle raised 30 px above the bar with a 4 px white ring.
- The customer navigation bar has 3 items (Explore, Orders, Profile). The active item gets a 56 × 32 vine-tint pill.
- Pickup codes are 6 characters and never use 0, O, 1 or I. The QR on the pickup pass encodes the code (K7Q2MX in the samples).
- Text must reflow at 130% system text size (see `C-19-pickup-pass-text-130`).
- Prices are in AED and VAT-inclusive; totals show "incl. VAT". Times use the 24-hour clock in GST (UTC+4).

## Admin dashboard (React or Next.js)

- `web-admin/tailwind.config.ts`: colours as `si-*` (e.g. `bg-si-primary`, `text-si-text-secondary`), radii `rounded-control` (12) and `rounded-card` (20), shadows `shadow-e1/e2/e3`, and the type scale as `text-si-*`.
- `web-admin/shadcn-globals.css`: shadcn/ui CSS variables mapped to Save It colours (HSL, exact to the hex). shadcn's "accent" is mapped to the vine tint used for hover and selected rows. Terracotta isn't used in the admin.
- `web-admin/tokens.css`: plain CSS variables (`--si-*`) and `.si-*` type classes, if you're not using Tailwind.
- Icons: `lucide-react`. Font: Titillium Web 400/600/700, e.g. `next/font/google`.
- Layout: sidebar 248, top bar 64, content padding 28 to 32, controls 40 tall, tables with 52 px rows, cards and tables at radius 20, dialogs 480 wide at radius 28.

## Tokens at a glance

| Token | Hex | Use |
|---|---|---|
| primary | #5B7B3A | Buttons, selected chips, active states; white text on it |
| primary-text | #587738 | Vine as text: links, active tab label |
| primary-container / on- | #E9EFE1 / #4F6B32 | Active tab pill, info notes, no-photo defaults |
| accent | #B5543A | Terracotta: discount badge, New dot, walkthrough dots, logo only |
| accent-text | #B15239 | Discounted price text |
| background / surface | #F7F3EC / #FFFFFF | Page / cards, sheets, dialogs |
| surface-muted | #EFEAE1 | Skeletons, segmented track, disabled |
| outline / outline-strong | #E2DBD0 / #8C847B | Hairlines / input and chip borders |
| text-primary / secondary | #1C1B19 / #6B635C | Text |
| success | #2E6B3A on #E4F0E2 | Collected, Live, Active |
| warning | #7A5200 on #FCEFD2 | Reserved, Warned |
| error | #B4233C on #FBE7EA | Errors, Cancelled, Suspended, destructive |
| neutral | #55504A on #ECE9E4 | Expired, Hidden, Sold out, Deactivated, offline |
| dark / business-badge | #2B2926 / #C6DDA8 | Business header, toasts |

Radii: 8 (thumbnails, code boxes), 12 (buttons, fields, toasts), 20 (cards, banners, basket bar), 28 (sheets, dialogs, tab bar top), full (chips, badges, stepper, tab pill).
Shadows: e1 `0 1 2 /6% + 0 4 12 /6%` cards · e2 `0 -4 16 /8%` bars · e3 `0 12 32 /18%` overlays · scrim #1C1B19 at 48%.
Spacing: 4, 8, 12, 16, 20, 24, 32, 48, 64.

## Business rules reflected in the designs

Commission 40% of what the customer pays, on collected orders, invoiced monthly · minimum discount 50% · pickup times 16:00 to 23:30 · max 2 per listing per order · max 2 active orders · reminder 30 min before the window closes · warning after 2 no-shows in a week · suspended at 3 no-shows in 30 days, and the suspension stays until an admin lifts it. · categories: Salads, Savoury Dishes, Sweet Treats, Beverages, Snacks, Bakery, Kids Menu · dietary tags: Vegetarian, Vegan, Gluten-free, Contains nuts, Lactose-free (the Filters chip reads "No nuts" and hides nut items) · 26 Abu Dhabi areas (Q-03; "Al Hisn", "Mohamed Bin Zayed City") · support contact@arisehub.org · emails from Save It <no-reply@arisehub.org>.

## Screen index

B-12 to B-14 (check-in) appear once, under `3-pickup`; Business mode uses the same screens.

### 1 · Customer sign-up

| Screen | File | Notes |
|---|---|---|
| C-01 Splash | `screens/1-customer-signup/C-01-splash@2x.png` | App shell |
| C-02 Location permission | `screens/1-customer-signup/C-02-location-permission@2x.png` | CA-02 · bottom sheet over a dimmed C-04 |
| C-03 Choose area | `screens/1-customer-signup/C-03-choose-area@2x.png` | CA-02 |
| C-12 Sign-up gate | `screens/1-customer-signup/C-12-sign-up-gate@2x.png` | CA-01 · bottom sheet over the C-11 basket |
| C-13 Complete your profile | `screens/1-customer-signup/C-13-complete-your-profile@2x.png` | CA-03 · new emails only |
| C-14 Continue with email | `screens/1-customer-signup/C-14-continue-with-email@2x.png` | CA-04 |
| C-15 Enter code · incorrect or expired (state) | `screens/1-customer-signup/C-15-enter-code-incorrect-or-expired@2x.png` | CA-04 |
| C-15 Enter code · resend limit reached (state) | `screens/1-customer-signup/C-15-enter-code-resend-limit-reached@2x.png` | CA-04 |
| C-15 Enter code | `screens/1-customer-signup/C-15-enter-code@2x.png` | CA-04 |
| C-22 Profile · guest | `screens/1-customer-signup/C-22-profile-guest@2x.png` | CA-01, CA-05 |
| C-22 Profile | `screens/1-customer-signup/C-22-profile@2x.png` | CA-05 |
| C-23 Edit profile | `screens/1-customer-signup/C-23-edit-profile@2x.png` | CA-05 |
| C-24 Delete account · active order (state) | `screens/1-customer-signup/C-24-delete-account-active-order@2x.png` | CA-05 · shown instead of the confirmation |
| C-24 Delete account confirmation | `screens/1-customer-signup/C-24-delete-account-confirmation@2x.png` | CA-05 |
| C-28 Email · Login code | `screens/1-customer-signup/C-28-email-login-code@2x.png` | CA-04 · also sent for Business mode logins (BM-01) |
| C-28 Email · Welcome | `screens/1-customer-signup/C-28-email-welcome@2x.png` | CA-16 · sent once, when a new customer completes C-13 |
| C-29 Walkthrough · 1 of 3 | `screens/1-customer-signup/C-29-walkthrough-1-of-3@2x.png` | CA-02 (first launch) |
| C-29 Walkthrough · 2 of 3 | `screens/1-customer-signup/C-29-walkthrough-2-of-3@2x.png` | CA-02 (first launch) |
| C-29 Walkthrough · 3 of 3 | `screens/1-customer-signup/C-29-walkthrough-3-of-3@2x.png` | CA-02 (first launch) |

### 2 · Browse and reserve

| Screen | File | Notes |
|---|---|---|
| C-04 Explore | `screens/2-browse-and-reserve/C-04-explore@2x.png` | CA-06 · restaurant list |
| C-05 Filters | `screens/2-browse-and-reserve/C-05-filters@2x.png` | CA-07 · bottom sheet over C-04 |
| C-06 Search results · no match (state) | `screens/2-browse-and-reserve/C-06-search-results-no-match@2x.png` | CA-07 |
| C-06 Search results | `screens/2-browse-and-reserve/C-06-search-results@2x.png` | CA-07 |
| C-07 Explore · nothing nearby (state) | `screens/2-browse-and-reserve/C-07-explore-nothing-nearby@2x.png` | CA-06 · empty state |
| C-08 Restaurant page | `screens/2-browse-and-reserve/C-08-restaurant-page@2x.png` | CA-08 |
| C-09 Item details | `screens/2-browse-and-reserve/C-09-item-details@2x.png` | CA-09, CA-10 · bottom sheet over C-08 |
| C-10 Different restaurant | `screens/2-browse-and-reserve/C-10-different-restaurant@2x.png` | CA-10 · dialog |
| C-11 Basket · active order limit (state) | `screens/2-browse-and-reserve/C-11-basket-active-order-limit@2x.png` | SR-07, CA-10 |
| C-11 Basket | `screens/2-browse-and-reserve/C-11-basket@2x.png` | CA-10, CA-12 |
| C-16 Confirm reservation | `screens/2-browse-and-reserve/C-16-confirm-reservation@2x.png` | CA-11, CA-12 |
| C-17 Stock changed (state) | `screens/2-browse-and-reserve/C-17-stock-changed@2x.png` | CA-11 · after Confirm |
| C-18 Notification permission | `screens/2-browse-and-reserve/C-18-notification-permission@2x.png` | CA-15 · after the first reservation only |
| C-25 No-show warning (state) | `screens/2-browse-and-reserve/C-25-no-show-warning@2x.png` | SR-04 · dismissible banner on C-04 |
| C-26 Reservations paused (state) | `screens/2-browse-and-reserve/C-26-reservations-paused@2x.png` | CA-17 · on the basket |
| C-27 Push · Order confirmed | `screens/2-browse-and-reserve/C-27-push-order-confirmed@2x.png` | CA-15 · lock screen |
| C-28 Email · Order confirmation | `screens/2-browse-and-reserve/C-28-email-order-confirmation@2x.png` | CA-16 · sent when the order is reserved |

### 3 · Pickup

| Screen | File | Notes |
|---|---|---|
| B-12 Scan code | `screens/3-pickup/B-12-scan-code@2x.png` | BM-09 · Business mode |
| B-13 Enter code | `screens/3-pickup/B-13-enter-code@2x.png` | BM-09 · Business mode |
| B-14 Pickup result · Already collected (state) | `screens/3-pickup/B-14-pickup-result-already-collected@2x.png` | BM-09 |
| B-14 Pickup result · Cancelled (state) | `screens/3-pickup/B-14-pickup-result-cancelled@2x.png` | BM-09, SR-05 |
| B-14 Pickup result · Expired (state) | `screens/3-pickup/B-14-pickup-result-expired@2x.png` | BM-09, SR-03 |
| B-14 Pickup result · Invalid code (state) | `screens/3-pickup/B-14-pickup-result-invalid-code@2x.png` | BM-09 |
| B-14 Pickup result · Success | `screens/3-pickup/B-14-pickup-result-success@2x.png` | BM-09 · Business mode |
| B-14 Pickup result · Too early (state) | `screens/3-pickup/B-14-pickup-result-too-early@2x.png` | BM-09 |
| C-19 Pickup pass · offline (state) | `screens/3-pickup/C-19-pickup-pass-offline@2x.png` | CA-13 |
| C-19 Pickup pass · text 130% (state) | `screens/3-pickup/C-19-pickup-pass-text-130@2x.png` | CA-13 · accessibility check |
| C-19 Pickup pass | `screens/3-pickup/C-19-pickup-pass@2x.png` | CA-13 |
| C-20 Orders · Active | `screens/3-pickup/C-20-orders-active@2x.png` | CA-14 |
| C-20 Orders · guest (state) | `screens/3-pickup/C-20-orders-guest@2x.png` | CA-01, CA-14 |
| C-20 Orders · Past | `screens/3-pickup/C-20-orders-past@2x.png` | CA-14 |
| C-21 Order details · Cancelled | `screens/3-pickup/C-21-order-details-cancelled@2x.png` | CA-14 |
| C-21 Order details · Expired (state) | `screens/3-pickup/C-21-order-details-expired@2x.png` | CA-14, SR-03 |
| C-27 Push notifications · after reserving | `screens/3-pickup/C-27-push-notifications-after-reserving@2x.png` | CA-15 · lock screen |
| C-28 Email · Order cancellation | `screens/3-pickup/C-28-email-order-cancellation@2x.png` | CA-16 · sent when a restaurant or an admin cancels (BM-10) |
| Common state · Empty list (state) | `screens/3-pickup/common-state-empty-list@2x.png` | Example: C-20 Orders, no orders yet |
| Common state · Error (state) | `screens/3-pickup/common-state-error@2x.png` | Example: C-04 Explore |
| Common state · Loading (state) | `screens/3-pickup/common-state-loading@2x.png` | Example: C-04 Explore · NF-03 |
| Common state · No internet (state) | `screens/3-pickup/common-state-no-internet@2x.png` | Example: C-20 Orders |

### 4 · Restaurant (Business mode)

| Screen | File | Notes |
|---|---|---|
| B-01 Business login | `screens/4-business-mode/B-01-business-login@2x.png` | BM-01 · opened from C-22 |
| B-02 Accept restaurant terms | `screens/4-business-mode/B-02-accept-restaurant-terms@2x.png` | BM-01 · first login only |
| B-03 Today · restaurant paused (state) | `screens/4-business-mode/B-03-today-restaurant-paused@2x.png` | BM-02, AD-02 |
| B-03 Today · window not set (state) | `screens/4-business-mode/B-03-today-window-not-set@2x.png` | BM-02 |
| B-03 Today | `screens/4-business-mode/B-03-today@2x.png` | BM-02 · Business mode home |
| B-04 Set pickup window | `screens/4-business-mode/B-04-set-pickup-window@2x.png` | BM-02, SR-02 |
| B-05 Listings | `screens/4-business-mode/B-05-listings@2x.png` | BM-05, BM-06 |
| B-06 Repeat yesterday | `screens/4-business-mode/B-06-repeat-yesterday@2x.png` | BM-04 |
| B-07 Add or edit listing · errors (state) | `screens/4-business-mode/B-07-add-or-edit-listing-errors@2x.png` | SR-01, BM-05 |
| B-07 Add or edit listing | `screens/4-business-mode/B-07-add-or-edit-listing@2x.png` | BM-03, BM-05, SR-01 · edit mode shown |
| B-08 Remove listing | `screens/4-business-mode/B-08-remove-listing@2x.png` | BM-05 · dialog over B-07 |
| B-09 Orders (today) | `screens/4-business-mode/B-09-orders-today@2x.png` | BM-08 |
| B-10 Order details | `screens/4-business-mode/B-10-order-details@2x.png` | BM-08, BM-10 |
| B-11 Cancel order | `screens/4-business-mode/B-11-cancel-order@2x.png` | BM-10 · bottom sheet over B-10 |
| B-15 Reports | `screens/4-business-mode/B-15-reports@2x.png` | BM-11, SR-06 |
| B-16 Restaurant account | `screens/4-business-mode/B-16-restaurant-account@2x.png` | BM-01 |
| B-17 New order notification | `screens/4-business-mode/B-17-new-order-notification@2x.png` | BM-07 · lock screen |
| Common state · Empty · no listings yet (state) | `screens/4-business-mode/common-state-empty-no-listings-yet@2x.png` | Example: B-05 Listings |
| Common state · Empty · no orders today (state) | `screens/4-business-mode/common-state-empty-no-orders-today@2x.png` | Example: B-09 Orders |
| Common state · Error (state) | `screens/4-business-mode/common-state-error@2x.png` | Example: B-05 Listings |
| Common state · Loading (state) | `screens/4-business-mode/common-state-loading@2x.png` | Example: B-03 Today |
| Common state · No internet (state) | `screens/4-business-mode/common-state-no-internet@2x.png` | Example: B-09 Orders |

### 5 · Admin (1440 × 900)

| Screen | File | Notes |
|---|---|---|
| A-01 Admin login | `screens/5-admin/A-01-admin-login@2x.png` | AD-01 · shown with its error state |
| A-02 Restaurants list | `screens/5-admin/A-02-restaurants-list@2x.png` | AD-02 |
| A-03 Add or edit restaurant | `screens/5-admin/A-03-add-or-edit-restaurant@2x.png` | AD-02, AD-03 · edit mode, address search open |
| A-04 Suspend restaurant | `screens/5-admin/A-04-suspend-restaurant@2x.png` | AD-02 · dialog over A-02 |
| A-05 Orders | `screens/5-admin/A-05-orders@2x.png` | AD-04, AD-05 |
| A-06 Order details | `screens/5-admin/A-06-order-details@2x.png` | AD-04 · side panel over A-05 |
| A-07 Export CSV | `screens/5-admin/A-07-export-csv@2x.png` | AD-05 · dialog over A-05 |
| A-08 Customers | `screens/5-admin/A-08-customers@2x.png` | AD-04 |
| A-09 Customer details | `screens/5-admin/A-09-customer-details@2x.png` | AD-04, SR-04 · lift-suspension confirmation open |
| A-10 Admins · Add admin | `screens/5-admin/A-10-admins-add-admin@2x.png` | AD-01 · dialog open |
| A-10 Reset password (state) | `screens/5-admin/A-10-reset-password@2x.png` | AD-01, NF-05 · dialog from a row |
| A-12 Change password | `screens/5-admin/A-12-change-password@2x.png` | AD-01, NF-05 · dialog from the account menu |
| Admin · Error (state) | `screens/5-admin/admin-error@2x.png` | Example: A-05 Orders |
| Admin · Loading (state) | `screens/5-admin/admin-loading@2x.png` | Example: A-02 Restaurants |
| Admin · No internet (state) | `screens/5-admin/admin-no-internet@2x.png` | Example: A-08 Customers |
| Admin · No search results (state) | `screens/5-admin/admin-no-search-results@2x.png` | Example: A-08 Customers |
| Top bar · account menu | `screens/5-admin/top-bar-account-menu@2x.png` | AD-01 · on every admin page |

### Emails and notifications

| Screen | File | Notes |
|---|---|---|
| B-17 New order | `screens/6-emails-and-notifications/B-17-new-order@2x.png` | BM-07 · to the restaurant's phone |
| C-27 Order cancelled | `screens/6-emails-and-notifications/C-27-order-cancelled@2x.png` | CA-15 · restaurant or admin cancels |
| C-27 Order confirmed | `screens/6-emails-and-notifications/C-27-order-confirmed@2x.png` | CA-15 · when the order is reserved |
| C-27 Order expired | `screens/6-emails-and-notifications/C-27-order-expired@2x.png` | CA-15 · when the window ends uncollected |
| C-27 Pickup reminder | `screens/6-emails-and-notifications/C-27-pickup-reminder@2x.png` | CA-15 · 30 min before the window closes |
| C-28 Email · Login code | `screens/6-emails-and-notifications/C-28-email-login-code@2x.png` | CA-04, BM-01 · customers and Business mode logins |
| C-28 Email · Order cancellation | `screens/6-emails-and-notifications/C-28-email-order-cancellation@2x.png` | CA-16 · sent when a restaurant or an admin cancels (BM-10) |
| C-28 Email · Order confirmation | `screens/6-emails-and-notifications/C-28-email-order-confirmation@2x.png` | CA-16 · sent when the order is reserved |
| C-28 Email · Welcome | `screens/6-emails-and-notifications/C-28-email-welcome@2x.png` | CA-16 · once, after C-13 |
