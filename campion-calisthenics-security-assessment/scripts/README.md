# Assessment Scripts

This directory contains the automation and testing scripts utilized during the authorized security audit of the Campion Calisthenics platform.

## Prerequisites
- `curl` (for HTTP requests)
- Unix-like environment (`bash` or `zsh`)

## Execution Context

To authenticate the scripts against the Supabase REST API, the public anonymous key must be loaded into the environment:

```bash
export API_KEY='YOUR_SUPABASE_ANON_KEY'
```

### Script Inventory
- `supabase-readonly.sh`: Automates read-only (`GET`) requests against the public Supabase endpoint to enumerate table accessibility and validate Row Level Security (RLS) constraints.
