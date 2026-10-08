# Finding 001 — Unauthorized High-Value Coupon Usage & Architectural Bypass

## Severity
**High (CVSS Score: 8.5)**

## Summary
An active coupon providing a 99% discount (`ELITE99`) was publicly exposed through the application's Supabase backend. Due to insufficient server-side validation, the client application was trusted to calculate the final transaction amount, allowing unauthenticated users to apply the discount through the public checkout flow without authorization.

## Evidence
- The coupon configuration was discoverable via the Supabase REST API utilizing the `anon` key.
- The checkout interface accepted the coupon code without server-side validation of the user's role or the coupon's intended audience.
- The payload sent to the backend relied on client-side state for pricing, resulting in a nearly complete discount (e.g., from €87.90 to €0.88).

## Impact
This represents a critical business logic flaw (Insecure Direct Object Reference / Client-Side Trust). An unauthorized actor could exploit this vulnerability to complete transactions at virtually zero cost, leading to severe financial loss and inventory depletion.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Database Isolation:** Row Level Security (RLS) was strictly enforced on the `coupons` table. Anonymous access was completely revoked, ensuring coupon metadata cannot be enumerated.
2. **Server-Side Validation:** The checkout API (`/api/checkout`) was refactored. The backend now authoritatively fetches product prices and validates coupon eligibility directly against the restricted database before generating the Stripe Payment Intent. Client-provided pricing is categorically ignored.
