#!/bin/bash

SUPA="https://buwvlmuvutfuvtxngqoi.supabase.co"

if [ -z "$API_KEY" ]; then
    echo "Set API_KEY before running."
    exit 1
fi

echo "[+] Testing public Supabase tables..."

echo
echo "=== PRODUCTS ==="
curl -s "$SUPA/rest/v1/products?select=id,slug,price_numeric,stock_quantity,is_active&limit=10" \
  -H "apikey: $API_KEY" \
  -H "Authorization: Bearer $API_KEY"

echo
echo
echo "=== COUPONS ==="
curl -s "$SUPA/rest/v1/coupons?select=id,code,type,value,is_active,starts_at,expires_at,usage_limit,used_count&limit=100" \
  -H "apikey: $API_KEY" \
  -H "Authorization: Bearer $API_KEY"

echo
echo
echo "=== STORE SETTINGS ==="
curl -s "$SUPA/rest/v1/store_settings?select=key,value&limit=100" \
  -H "apikey: $API_KEY" \
  -H "Authorization: Bearer $API_KEY"

echo
echo
echo "=== REVIEWS ==="
curl -s "$SUPA/rest/v1/reviews?select=id,status,created_at&limit=100" \
  -H "apikey: $API_KEY" \
  -H "Authorization: Bearer $API_KEY"

echo
echo
echo "=== ORDERS ==="
curl -s "$SUPA/rest/v1/orders?select=*&limit=10" \
  -H "apikey: $API_KEY" \
  -H "Authorization: Bearer $API_KEY"

echo
