# 06. Notifications and emails

Every message is queued in `outbox` in the same transaction as the event that causes it, then sent by the `dispatch` Edge Function. A message is never sent from inside a request handler, so a slow FCM or Resend call never blocks a reservation.

## 1. Push notifications (FCM)

| Template | Trigger | To | Title / body | Tap opens | Req |
|---|---|---|---|---|---|
| `order_confirmed` | `reserve_order` succeeds | Customer | "Order confirmed" / "{restaurant}: pick up {window}. Code {code}" | `/orders/{id}` | CA-15 |
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
| `welcome` | Customer completes the profile (`complete_profile`, C-13) | Short welcome, how Save it works (reserve, collect, pay at the counter), support email | CA-16 |
| `order_confirmation` | `reserve_order` | Code (large), restaurant name and address, Directions link, pickup window, items, total to pay at the counter, no-show note | CA-16 |
| `order_cancellation` | `cancel_order` | Restaurant, reason, items, apology line, link to explore other restaurants | CA-16 |

- **Sender:** `Save it <no-reply@{client domain}>`, from a domain the client verifies in Resend (SPF, DKIM, DMARC). This is set up in T01.2 and T12.3.
- **Format:** templates are plain responsive HTML in `supabase/functions/_shared/emails/`, each with a plain-text version.
- **Look:** brand colours, the logo, and the support email in the footer.
