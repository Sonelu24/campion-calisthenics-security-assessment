# HTTP Security Headers

The application was observed behind Vercel infrastructure.

The following security-related headers were identified:

- Strict-Transport-Security
- X-Content-Type-Options: nosniff
- X-Frame-Options: DENY
- Referrer-Policy: strict-origin-when-cross-origin
- Permissions-Policy

## Content Security Policy

A Content-Security-Policy header was present.

The policy allows communication with the application's Supabase project.

The policy also contains `unsafe-inline` and `unsafe-eval`. Their presence alone does not demonstrate an exploitable vulnerability and no XSS vulnerability was confirmed during this assessment.
