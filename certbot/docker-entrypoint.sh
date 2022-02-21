#!/usr/bin/env sh

set -eu

cat >/credentials.ini <<EOF
dns_cloudflare_email = $DNS_CLOUDFLARE_EMAIL
dns_cloudflare_api_key = $DNS_CLOUDFLARE_API_KEY
EOF

chmod 600 /credentials.ini

echo "certbot $@"
exec certbot "$@"
