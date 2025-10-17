#!/bin/bash

# etener en caso de error
set -e

# Lista de dominios (agrega más según necesites)
domains=(
  app.fusionatech.com
)

# Correo para notificaciones de Let's Encrypt
email="yadirrh88@gmail.com"

# Usa staging para pruebas (0 = producción, 1 = pruebas)
staging=0

# Ruta webroot compartida con Nginx
webroot_path="/var/www/certbot"

# Generar certificados para cada dominio
for domain in "${domains[@]}"; do
  echo "Generando certificado para $domain..."

  docker compose run --rm certbot certonly \
    --webroot -w $webroot_path \
    --email $email \
    --agree-tos \
    --no-eff-email \
    --force-renewal \
    ${staging:+--staging} \
    -d $domain
done

echo "Certificados generados correctamente."
