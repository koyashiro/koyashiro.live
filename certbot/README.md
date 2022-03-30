# certbot

## certonly

```sh
docker compose run --rm certonly
ln -s "$PWD/etc/letsencrypt/live/$DOMAIN/fullchain.pem" "$PWD/../fullchain.pem"
ln -s "$PWD/etc/letsencrypt/live/$DOMAIN/privkey.pem" "$PWD/../privkey.pem"
```

## renew

```sh
docker compose run --rm renew
```
