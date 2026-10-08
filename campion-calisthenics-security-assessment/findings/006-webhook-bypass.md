# Finding 006 — Stripe Webhook Signature Bypass

## Severity
**Critical (CVSS Score: 9.1)**

## Summary
The Stripe webhook endpoint (`/api/webhook`) contained an architectural flaw in how it handled the verification secret. If the `STRIPE_WEBHOOK_SECRET` environment variable was missing from the server environment, the signature verification function was bypassed entirely, allowing unverified payloads to be processed as legitimate payment events.

## Evidence
Code analysis revealed that the secret was passed directly into `stripe.webhooks.constructEvent()` without a strict null or undefined check, meaning an empty string would cause the library to fail open or accept forged signatures under specific conditions.

## Impact
An attacker aware of this misconfiguration could send forged `payment_intent.succeeded` events directly to the webhook URL. The system would then mark unpaid orders as fulfilled, leading to stolen merchandise and severe financial discrepancies.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Fail-Fast Initialization:** The webhook route was updated to rigorously assert the presence of `STRIPE_WEBHOOK_SECRET` at initialization.
2. **Strict Verification:** If the secret is missing, the endpoint immediately returns an HTTP 500 error and refuses to parse the event, ensuring no untrusted payloads ever interact with the business logic.
