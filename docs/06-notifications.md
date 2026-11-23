# 06. Notifications and emails

Every message is queued in `outbox` in the same transaction as the event that causes it, then sent by the `dispatch` Edge Function. A message is never sent from inside a request handler, so a slow FCM or Resend call never blocks a reservation.

## 1. Push notifications (FCM)

| Template | Trigger | To | Title / body | Tap opens | Req |
|---|---|---|---|---|---|
| `order_confirmed` | `reserve_order` succeeds | Customer | "You've saved it!" / "Hi {name}, your order is reserved, you saved it!" | `/orders/{id}` | CA-15 |
| `pickup_reminder` | `send_reminders` job, `reminder_minutes` before the window ends | Customer | "Pickup closes soon" / "Collect from {restaurant} by {end}" | `/orders/{id}` | CA-15 |
| `order_cancelled` | `cancel_order` | Customer | "Order cancelled" / "{restaurant} cancelled your order: {reason}" | `/orders/{id}` | CA-15 |
| `order_expired` | `expire_orders` job | Customer | "Order expired" / "Your order from {restaurant} wasn't collected in time" | `/orders/{id}` | CA-15 |
| `new_order` | `reserve_order` succeeds | Restaurant user (all devices) | "New order" / "{n} items, AED {total}, pickup {window}" | `/business/orders/{id}` | BM-07 |

- **iOS:** set the APNs key in each Firebase project.
- **Android:** use a single high-importance channel named "Orders".
- **Invalid tokens:** if FCM returns `UNREGISTERED`, the token is deleted.

## 2. Emails (Resend)

| Template | Trigger | Content | Req |
|---|---|---|---|
| `login_code` | Auth Send Email Hook | The 6-digit code, "expires in 10 minutes", and a note to ignore the email if you didn't request it | CA-04, BM-01 |
| `welcome` | Customer completes the profile (`complete_profile`, C-13) | Subject "You're in! Welcome to Save It". Body starts "Hi {name}, Marhaba! Welcome to Save It! You are now with many others who have joined this good sustainability act of helping to reduce food waste in the UAE whilst saving money too - it's a win win!" then the first walkthrough paragraph, then the support email | CA-16 |
| `order_confirmation` | `reserve_order` | Subject "You've saved it!". Then the code (large), restaurant name and address, Directions link, pickup window, items, and the total to pay at the counter. The client's draft says to follow the same description as the welcome mail; keep the order facts above that paragraph | CA-16 |
| `order_cancellation` | `cancel_order` | Restaurant, reason, items, apology line, link to explore other restaurants | CA-16 |

- **Sender:** `Save It <no-reply@arisehub.org>` once `arisehub.org` is verified in Resend (SPF, DKIM, DMARC). The dev project has no verified domain, so its `RESEND_FROM` secret is `Save It <onboarding@resend.dev>`, and Resend will deliver those messages only to the address on the Resend account. The support address in the footer is `contact@arisehub.org`.
- **Format:** templates are plain responsive HTML in `supabase/functions/_shared/emails/`, each with a plain-text version.
- **Look:** brand colours, the logo, and the support email in the footer.
