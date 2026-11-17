# 12. Roadmap: after the Lean Package

These features were deliberately left out of the Lean Package. Each can be added later as a Change Request. The notes show where the current design already leaves room for each one, so adding it later doesn't mean rework.

| Feature | Room left in the current design |
|---|---|
| **Ratings and reviews, plus a private "Report a problem"** (food-safety quality control) | Orders already record `collected_at`, so "only rate collected orders" is easy to enforce. Would add a `reviews` table, an aggregate on `restaurants`, admin moderation and an outbox email to admins. |
| **Interactive map** | Restaurant locations are already stored as PostGIS points, and `nearby_restaurants` returns distances. A map view would use the same RPC. |
| **Online card payments** | Orders already store the total and a commission snapshot. Would add a payment intent ID, a `paid` status and a Stripe Connect payout flow. |
| **SMS login** | Supabase Auth supports phone OTP. Phone numbers are already collected in E.164 format. |
| **Arabic and right-to-left layout** | All strings are in `app_en.arb`; add `app_ar.arb`, the RTL check and Arabic fonts. Emails would need Arabic templates. |
| **Restaurant self-registration and approval** | The `admin-create-restaurant` logic could be reused behind an approval queue; add document uploads to storage. |
| **Restaurants editing their own profile and hours** | Currently admin-only under RLS; open specific columns to restaurant users. |
| **Multiple staff logins per restaurant** | Would add a `restaurant_members` table to replace `restaurants.user_id`, and update `my_restaurant_id()`. |
| **Customer self-cancellation** | `cancel_order` already returns stock; allow the customer role with a cut-off time. |
| **Several pickup windows a day** | Remove the `(restaurant_id, date)` unique rule and add `pickup_window_id` to listings. |
| **Admin settings page** (commission, minimum discount and so on) | Values already live in `app_settings`; it would just need a form plus the audit log. |
| **Admin analytics dashboard, usage analytics** | Orders data supports reports. Would add an analytics SDK with consent. |
| **Automated store releases** (promotion to production and App Store submission from the pipeline) | The developer's own pipelines already build and upload to the test tracks; only the final promotion is manual. |
| **Arise Hub company website** | Separate quote. |
