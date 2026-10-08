# Finding 007 — Absence of Cross-Site Request Forgery (CSRF) Protection

## Severity
**High (CVSS Score: 7.1)**

## Summary
State-changing API routes (such as checkout and cart updates) did not validate the origin of requests using anti-CSRF tokens. While CORS policies provide some protection, they are insufficient against advanced CSRF vectors.

## Evidence
Manual testing demonstrated that an authenticated session could be leveraged to execute state-changing actions via a cross-origin form submission without requiring any specific nonce or token validation.

## Impact
If an authenticated user visits a malicious website, an attacker could force the user's browser to execute unwanted actions (such as altering the cart or initiating a checkout) on `campion-calisthenics.ro` using the victim's session cookies.

## Remediation & Hardening Strategy
**Status: Resolved (Implemented & Verified)**

1. **Synchronizer Token Pattern:** Integrated a robust CSRF protection mechanism generating a cryptographically secure token.
2. **HttpOnly Storage:** The token is securely stored via `HttpOnly` cookies and validated strictly on all state-modifying requests (`POST`, `PUT`, `DELETE`). Requests lacking the valid `x-csrf-token` header are rejected with HTTP 403 Forbidden.
