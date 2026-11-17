# Save it: Technical Plan

This is the technical plan for building the Save it Lean Package: an iOS and Android app with a restaurant Business mode, plus a web admin. It turns the SRS and wireframes into a buildable design and a week-by-week task list, from setup to store submission and admin deployment.

| | |
|---|---|
| Version | 0.2 (18 November 2026) |
| Based on | SRS v0.3, Wireframes (17 November 2026), Business Rules Sheet, Development Agreement dated 27 October 2026 |
| Timeline | 12 weeks, Monday 16 November 2026 to Friday 5 February 2027 |
| Owner | Daniel Terefe |

## How to use this plan

1. **Get the context:** read `01-architecture.md` once.
2. **Work week by week:** each week has its own file in `phases/` with:
   - the goal and the end-of-week deliverable
   - the tasks, each with an ID, who does it ("You" or "Claude Code"), the SRS IDs and a "Done when" check
   - what to send Miss Reid in Friday's update
   - a ready-made **Claude Code prompt** for that week's coding tasks
3. **Use the reference docs:** while working on a task, use them for the details: database, API, app, admin, notifications and pipelines.
4. **Keep it current:**
   - Tick finished tasks (`[x]`).
   - If a decision changes, update the reference doc in the same pull request.
   - When the SRS changes through a Change Request, add the new tasks to the current week, with a CR number.

## Contents

| File | What it covers |
|---|---|
| [01-architecture.md](01-architecture.md) | System overview, components, environments, key flows, security model |
| [02-database.md](02-database.md) | Tables, enums, constraints, indexes, RLS matrix, settings, scheduled jobs, storage |
| [03-backend-api.md](03-backend-api.md) | RPC functions, Edge Functions, error codes |
| [04-mobile-app.md](04-mobile-app.md) | Flutter structure, packages, flavors, routes mapped to screen IDs, behaviour |
| [05-admin-web.md](05-admin-web.md) | Next.js admin structure, pages, Places search, CSV export |
| [06-notifications.md](06-notifications.md) | Every push and email: trigger, recipient, content |
| [07-conventions.md](07-conventions.md) | Code style, branching, commits, versions, definition of done |
| [08-testing.md](08-testing.md) | Test strategy and the core-flow tests promised in the agreement |
| [09-release.md](09-release.md) | Production cutover, App Store and Google Play checklists |
| [10-handover.md](10-handover.md) | Handover checklist and maintenance routine |
| [11-risks.md](11-risks.md) | Risk register |
| [12-roadmap.md](12-roadmap.md) | Features excluded from the Lean Package and how the design leaves room for them |
| [13-ci-cd.md](13-ci-cd.md) | GitHub Actions, Codemagic (iOS without a Mac) and Vercel pipelines |
| [design/ui-design-prompt.md](design/ui-design-prompt.md) | Prompt for the high-fidelity UI design in Claude Design |
| [phases/](phases/) | One plan per week, with Claude Code prompts |

## Weekly plan

| Week | Dates | Milestone | Focus |
|---|---|---|---|
| [1](phases/week-01.md) | 16–20 Nov | M1 Discovery and Design | Project setup |
| [2](phases/week-02.md) | 23–27 Nov | M1 | UI design and SRS sign-off |
| [3](phases/week-03.md) | 30 Nov–4 Dec | M2 Core Build | Database and authentication |
| [4](phases/week-04.md) | 7–11 Dec | M2 | App shell, sign-in, first store builds |
| [5](phases/week-05.md) | 14–18 Dec | M2 | Business mode: pickup window and listings |
| [6](phases/week-06.md) | 21–25 Dec | M2 | Customer discovery and basket |
| [7](phases/week-07.md) | 28 Dec–1 Jan | M2 | Reservation, pickup pass, order history |
| [8](phases/week-08.md) | 4–8 Jan | M2 | Pickup, cancellation, expiry, account deletion; M2 demo |
| [9](phases/week-09.md) | 11–15 Jan | M3 Admin and Beta | Admin, part 1 |
| [10](phases/week-10.md) | 18–22 Jan | M3 | Admin, part 2, and notifications |
| [11](phases/week-11.md) | 25–29 Jan | M3 | Reports, quality pass, beta (invoice: Beta Delivery, $1,896) |
| [12](phases/week-12.md) | 1–5 Feb | M4 Testing and Launch | Client testing, production, store submission, handover (invoice: Launch Submission, $1,422) |

Maintenance ($130 a month for 2 months) starts after submission.
