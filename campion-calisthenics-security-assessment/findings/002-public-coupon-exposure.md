# Finding 002 — Public Exposure of Promotional Configurations

## Severity
**Medium (CVSS Score: 6.5)**

## Summary
The `coupons` table lacked Row Level Security (RLS) policies, allowing it to be queried directly through the public Supabase REST API using the anonymous application key. This exposed sensitive internal promotional strategies and active discount codes to any unauthorized observer.

## Evidence
A standard GET request to `/rest/v1/coupons` utilizing the public `anon` key returned complete records, including:
- Coupon codes (e.g., `ELITE99`, `WELCOME10`)
- Discount values and types (percentage vs. fixed)
- Active status flags
- Start and expiration timestamps
- Usage limits and current redemption counts

## Impact
Unauthorized entities could programmatically enumerate all past, present, and future promotional campaigns. This facilitates financial abuse, allows competitors to monitor marketing strategies, and bypasses the intended distribution channels for promotional discounts.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Row Level Security (RLS):** An SQL migration (`003_secure_rls_policies.sql`) was deployed to activate RLS on the `coupons` table.
2. **Access Revocation:** The default open access was dropped. A strict policy was applied granting `ALL` privileges exclusively to the backend `service_role`. Anonymous read access (`SELECT`) was entirely eliminated.
