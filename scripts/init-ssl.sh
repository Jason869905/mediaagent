#!/bin/bash
set -e

mkdir -p certbot/www certbot/conf

# First run: get initial certificate via standalone mode
docker run --rm \
  -p 80:80 \
  -v ./certbot/conf:/etc/letsencrypt \
  certbot/certbot certonly --standalone \
  --non-interactive --agree-tos \
  --email contact@hollyhook.com \
  -d hollyhook.com -d www.hollyhook.com

echo "SSL certificate obtained successfully."
echo "Now run: docker compose up -d"
