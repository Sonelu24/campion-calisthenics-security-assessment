# Finding 008 — Insecure Direct Object Reference (IDOR) on Review Submission

## Severity
**Medium (CVSS Score: 5.5)**

## Summary
The product review submission architecture relied heavily on client-side state. The frontend application submitted the entire review payload, including a hardcoded `status: 'approved'` field, directly to the backend API.

## Evidence
By intercepting the HTTP request using a proxy, it was possible to inject arbitrary values into the `status` field, bypassing the administrative moderation phase entirely and publishing reviews immediately.

## Impact
Malicious actors could spam the storefront with inappropriate content, false claims, or competitor advertisements, damaging the brand's reputation.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Server Actions Migration:** The review insertion logic was migrated from the client to Next.js *Server Actions*.
2. **Authoritative Backend State:** The server action forcibly overrides the status to `pending`, ignoring any client-supplied state. The review is securely written to the database utilizing the `supabaseAdmin` client, awaiting authorized manual approval via the administrative dashboard.
