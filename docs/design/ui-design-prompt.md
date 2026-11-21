# UI design prompt (Claude Design)

Use this in Week 2 (T02.1). Attach `Save it - Wireframes.pdf` and the SRS PDF to the Claude Design conversation, then paste everything below the line.

Before running it, fill in the two placeholders if Miss Reid has answered: the logo file and the font. If she hasn't, leave the placeholders; the prompt handles both cases.

---

Turn the attached **Save It** low-fidelity wireframes into high-fidelity UI designs. Save It is a mobile app (iOS and Android) and web admin that lets Abu Dhabi restaurants sell end-of-day surplus food at a discount. Customers reserve items, collect them during the restaurant's pickup window with a QR or 6-character code, and pay at the counter. Restaurants use a "Business mode" in the same app. The Save It team uses a desktop web admin. The wordmark is "Save It", including the capital I.

The wireframes and the attached SRS are the source of truth for **what is on each screen and how screens connect**. Your job is the **look**: visual style, hierarchy, spacing, components and states. Do not add, remove or rename screens, fields, buttons or features. If something in a wireframe looks wrong or unclear, list it in a "Questions" frame instead of changing it.

## 1. Brand

- **Primary (actions, active tab, links):** vine green `#5B7B3A`. Text on it is white.
- **Accent:** terracotta red `#B5543A`. Use it sparingly: the discount price and discount badge, "New" dots, and highlights in the walkthrough illustrations. Never use it for errors.
- **Background:** off-white `#F7F3EC`. Cards and sheets are white `#FFFFFF`.
- **Text:** near-black `#1C1B19`. Secondary text is a warm grey at 4.5:1 contrast or better on both backgrounds.
- **Status colours** (each with a tinted background and a darker text version):
  - success green, for Collected
  - amber, for warnings and Reserved
  - error red, distinct from terracotta, for errors and Cancelled
  - neutral grey, for Expired and Hidden
- **Font:** [Titillium Web, unless the client says otherwise]. Use regular, semibold and bold only.
- **Logo:** `docs/businessrules-and-contents/La Logo.png`. Do not draw a replacement mark. Walkthrough illustrations are `Cycle.png`, `La point.png` and `La pay.png` in that folder, and the location pin is `image_7e411891.jpg`.
- **Personality:** warm, fresh, trustworthy and practical. It's about good food not going to waste, so it should feel appetising and calm, not discount-store loud. Food photos are the hero on restaurant and item cards.
- **Contrast:** check every text and colour pair meets WCAG AA (4.5:1 body, 3:1 large text and icons). If terracotta text on off-white fails, darken it slightly and note the final hex.

## 2. Deliver in this order

1. **Style guide (one frame):**
   - colour tokens with hex values and names (`primary`, `accent`, `surface`, `background`, `text-primary`, `text-secondary`, the status colours)
   - type scale (display, title, headline, body, label, caption, with sizes and line heights)
   - spacing scale (4-pt based), corner radii, elevation or shadows
   - icon style (one rounded outline icon set throughout)
2. **Component sheet (mobile):**
   - buttons (primary, secondary, text, destructive, disabled, loading)
   - text fields (default, focus, error, disabled), 6-box code input
   - search bar, filter chips (selected and unselected), bottom tab bar (customer and Business mode, with the raised Scan button)
   - restaurant card, item row, basket bar, quantity stepper, price (discounted with original crossed out)
   - status badges (Reserved, Collected, Cancelled, Expired; Draft, Live, Sold out, Hidden)
   - banners (offline, no-show warning, suspended), bottom sheet, dialog, toast or snackbar
   - empty, loading (skeleton) and error states
3. **Customer app screens:** every C-xx frame in sections 1–3 of the wireframes at 390 × 844, including every state and variant shown (guest variants, offline pass, active-order delete block, and so on).
4. **Business mode screens:** every B-xx frame, including Today with the window-not-set and suspended states, every pickup result (Success, Invalid, Already collected, Expired, Cancelled, Too early), and the listing form error states. Business mode should look like the same app, with a clear "Business mode" marker in the header so staff never confuse it with the customer side.
5. **Admin web screens:** every A-xx frame at 1440 × 900, in a clean, dense, professional style using the same colour tokens and font. It should be buildable with shadcn/ui components: data tables, side panel, dialogs, form controls. No charts.
6. **Emails and notifications:** the 4 email templates (login code, welcome, order confirmation, order cancellation) at 600 px width, and the push notification examples.

## 3. Rules

- **One design for both platforms.** Use platform-neutral components (Material 3 base, adjusted to the brand) that look at home on iOS and Android. Keep safe areas, iOS home-indicator spacing and Android back behaviour in mind.
- **Touch targets** are at least 44 × 44. Text must still work at 130% system text size; show one example screen at large text.
- **Prices** are in AED: "AED 15", or "AED 12.50" when there are fils. Times are 24-hour (for example "Pickup 20:00 to 21:30").
- **The pickup pass** (C-19) must be easy to scan in a busy shop: large QR, high contrast, big 6-character code, no decoration behind the QR.
- **Photos:** use realistic food photo placeholders (bakery boxes, meals, desserts) for restaurant and item images. Make sure the default-image style for items without a photo looks intentional (a category illustration on a tinted background).
- **Walkthrough illustrations** (C-29): three simple, friendly illustrations in the brand colours: a restaurant with surplus food, reserving on a phone, collecting at the counter.
- **Keep the labels:** every frame keeps its screen ID and name (for example "C-07 Restaurant page") so it maps back to the wireframes and SRS.
- **Out of scope:** no maps, ratings or reviews, online payments, favourites, chat, Arabic or extra settings screens.

## 4. Output

- **Layout:** one canvas per section, in the same order and with the same section names as the wireframes. The style guide and component sheet go first.
- **Exports:** each section must be exportable as a PNG for the SRS and for developer handoff.
- **Questions frame:** at the end, list any wireframe issues you found and any decisions you made that weren't specified (for example a darkened accent hex).
