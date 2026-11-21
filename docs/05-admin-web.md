# 05. Admin web (Next.js)

The admin is a desktop web app for the Save It team. It runs on Next.js (App Router, TypeScript), uses shadcn/ui components, and is hosted on Vercel. The supported browsers are current Chrome, Safari and Edge (NF-02).

## 1. Structure

```
admin/
├── app/
│   ├── login/page.tsx                    A-01
│   ├── (dashboard)/layout.tsx            sidebar + top bar; server-side admin check
│   ├── (dashboard)/restaurants/          A-02, A-03 (new, [id]), A-04
│   ├── (dashboard)/orders/               A-05, A-06 (side panel), A-07
│   ├── (dashboard)/customers/            A-08, A-09 ([id])
│   ├── (dashboard)/admins/               A-10
│   └── api/
│       ├── places/autocomplete/route.ts  Google Places proxy (AD-03)
│       ├── places/details/route.ts
│       └── export/orders/route.ts        CSV stream (AD-05)
├── components/ui/                        shadcn components
├── components/                           data-table, opening-hours-editor, address-search, confirm-dialog
├── lib/supabase/{server,client}.ts       @supabase/ssr
├── lib/errors.ts                         SIxxx → messages
└── proxy.ts                              refresh session; redirect to /login unless role = admin and active
                                          (Next.js 16 renamed middleware.ts to proxy.ts)
```

## 2. Pages

| Page | Data source | Notes |
|---|---|---|
| Login | Supabase Auth, email and password | Deactivated admins are blocked. No "Forgot password" link. |
| Account menu (top bar) | Supabase Auth | "Change password" dialog (A-12): current password, new password (min 12), confirm; and "Log out" |
| Restaurants | `restaurants` table (admin RLS) | Search by name, area or login email; status filter; pagination of 25 |
| New / edit restaurant | `admin-create-restaurant` Edge Function, or a table update for edits | Name, logo upload to `restaurant-logos`, area dropdown, address search and map pin, opening hours (7 rows, each with a Closed toggle), manager email (the login), manager phone, status. BR-13 documents (trade licence, Emirates ID, ADAFSA permit, and the rest of that list) are checked offline. The admin does not upload them |
| Orders | `admin_search_orders` | Filters for date range, restaurant and status. The side panel shows the timeline and a Cancel button that calls `cancel_order` with a reason. |
| Export | `/api/export/orders` | Streams CSV with the columns: order code, date, restaurant, items, quantities, total, commission, status |
| Customers | `admin_search_customers` | Shows the no-show count and status. Suspend and lift go through `admin_set_customer_status`. |
| Admins | `profiles where role = admin` | Add uses `admin-create-admin`; row actions Deactivate and Reset password (`admin-reset-password`), hidden on your own row |

There is no dashboard with charts and no settings page (excluded from the lean package). After login, the admin lands on Restaurants.

## 3. Address search (AD-03, NF-10)

The address search runs through server routes so the Google key never reaches the browser:
- **Autocomplete:** `POST /api/places/autocomplete` with `{input, sessionToken}` calls `https://places.googleapis.com/v1/places:autocomplete` with `includedRegionCodes: ["ae"]`.
- **Details:** `GET /api/places/details?placeId&sessionToken` calls `places/{id}` with the field mask `id,formattedAddress,location`. These are Essentials fields only.

The client component `address-search`:
- creates a `crypto.randomUUID()` session token when the field gets focus
- waits until at least 3 characters are typed, with a 300 ms debounce
- keeps one session token until the admin selects a result, then starts a new one
- shows the saved `formatted address` and the `lat, lng` as text, with no map

Edits keep the saved `place_id` and location unless the admin searches again.

The key is restricted to the Places API (New), with a daily quota cap of 500 requests as a safety net. At expected volumes the cost is $0, within Google's free monthly allowance.

## 4. Deployment

- **Vercel project `saveit-admin`** with the GitHub integration (details in `13-ci-cd.md` §6):
  - Pull requests get preview deployments.
  - `main` deploys to the dev environment.
  - The `production` branch deploys to production, using prod Supabase.
- **Environment variables:** `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` (the public client key; `NEXT_PUBLIC_SUPABASE_ANON_KEY` is still accepted), `SUPABASE_SERVICE_ROLE_KEY` (server only, used for the CSV export route) and `GOOGLE_PLACES_KEY`.
- **Domain:** for example `admin.<client-domain>`, set up in T12.3.
