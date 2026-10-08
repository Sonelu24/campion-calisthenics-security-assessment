# Finding 004 — Broad Exposure of Supabase Infrastructure and Deficient Granular Access Control

## Severity
**High (CVSS Score: 7.2)**

## Summary
The application relied heavily on the default Supabase configuration, leading to the broad exposure of multiple database tables (`products`, `categories`, `reviews`, `shipping_rates`, `orders`). While some tables (`products`) require public read access to function as a storefront, the lack of granular Column-Level Security (CLS) and Row-Level Security (RLS) allowed anonymous users to extract sensitive internal columns (timestamps, inventory counts) and, in certain cases, manipulate state (e.g., Unauthorized UPDATE on product stock).

## Evidence
- The `products` table allowed `SELECT *`, exposing internal fields like `created_at`, `updated_at`, `uuid`, and exact `stock_quantity`.
- The absence of restrictive RLS implicitly permitted state modification (UPDATE) by anonymous actors on public-facing tables.
- The `reviews` table permitted the extraction of unmoderated (pending/rejected) feedback.

## Impact
This configuration flaw introduces a multi-faceted risk:
1. **Inventory Manipulation:** Attackers could deplete stock values via unauthorized `UPDATE` queries.
2. **Information Disclosure:** Exposing exact stock counts and creation timestamps allows competitors to track inventory turnover and product lifecycle.
3. **Data Integrity:** Unmoderated reviews could be read publicly or manipulated.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Strict RLS Implementation:** Read access to the `reviews` table was constrained to return exclusively records where `status = 'approved'`. The `orders` table was completely isolated to backend-only access.
2. **Column-Level Security (CLS):** Wildcard `SELECT` access was revoked for the `anon` role on the `products` table. Explicit `GRANT` statements were issued strictly for safe UI-rendering columns (`id`, `slug`, `name`, `price`, `description`, etc.), permanently shielding stock and timestamp metadata.
3. **Write Protection:** RLS policies were configured to explicitly deny any `INSERT`, `UPDATE`, or `DELETE` operations from unauthenticated users across all public-facing tables.
