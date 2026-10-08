# Route Reconnaissance

## Public Routes

- `/`
- `/ro`
- `/en`
- `/admin/login`

## Protected Administrative Routes

The following routes redirected unauthenticated users to `/admin/login`:

- `/admin`
- `/admin/customers`
- `/admin/orders`
- `/admin/invoices`
- `/admin/coupons`
- `/admin/marketing/broadcast`

## Non-existing / Unavailable Routes Tested

- `/admin/users`
- `/admin/settings`
- `/admin/oauth/clients`
- `/admin/generate_link`
- `/admin/custom-providers`

These returned HTTP 404.

## Checkout

A public checkout endpoint was identified:

`POST /api/checkout`
