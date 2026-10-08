# Finding 003 — Exposure of Internal Store Settings and Metadata

## Severity
**Medium (CVSS Score: 5.3)**

## Summary
The `store_settings` table was accessible using the public Supabase anonymous key due to the absence of Row Level Security (RLS). This table contained internal operational metrics and configuration variables that are not intended for public consumption.

## Evidence
A query to `/rest/v1/store_settings` using the `anon` key returned records such as:
- `invoice_counter`: `36`
- Internal administrative flags and routing metadata.

## Impact
While the exposed data did not contain Customer PII (Personally Identifiable Information) or payment credentials, it provided unauthorized insights into the business's operational volume (e.g., transaction counts via `invoice_counter`). This type of information disclosure aids attackers in reconnaissance and competitive analysis.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Row Level Security Enforcement:** The `store_settings` table was secured via RLS in the `003_secure_rls_policies.sql` migration.
2. **Principle of Least Privilege:** Public access was entirely revoked. The table is now exclusively accessible to the backend system utilizing the `service_role` authentication context.
