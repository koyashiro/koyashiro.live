# koyashiro.live

## Certificate

### Obtain a certificate using a Cloudflare provider

```sh
docker compose run --rm lego --domains "$DOMAINS" --email "$EMAIL" --dns cloudflare --path /etc/lego --accept-tos run
```

### Renew a certificate using a Cloudflare provider

```sh
docker compose run --rm lego --domains "$DOMAINS" --email "$EMAIL" --dns cloudflare --path /etc/lego renew --days 30
```
