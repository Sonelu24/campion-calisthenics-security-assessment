# Finding 005 — Missing Rate Limiting on Critical Endpoints

## Severity
**High (CVSS Score: 7.5)**

## Summary
The application lacked Rate Limiting (throttling) on computationally expensive and external-facing endpoints, notably `/api/checkout`. This vulnerability left the platform susceptible to Application-Layer Denial of Service (DoS) attacks, brute forcing, and quota exhaustion of third-party APIs (Stripe, Packeta).

## Evidence
Sequential requests sent rapidly to `/api/checkout` were processed without any HTTP 429 (Too Many Requests) responses, indicating the total absence of throttling mechanisms.

## Impact
A malicious actor could execute a volumetric attack, exhausting server resources, inflating infrastructure costs, and potentially rendering the storefront unavailable to legitimate customers.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **In-Memory Rate Limiting:** Implemented `@upstash/ratelimit` paired with a Redis backend.
2. **Algorithm Applied:** A *Sliding Window* algorithm was configured with specific quotas tailored to each endpoint (e.g., 5 requests per minute for checkout initiation).
3. **Fail-Open Safeguard:** The implementation includes a `try-catch` wrapper ensuring that if Redis experiences downtime, the system fails open, preserving revenue flow while logging the anomaly.
