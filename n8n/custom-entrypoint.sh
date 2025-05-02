#!/bin/sh

# Load dynamic environment from ngrok
ENV_FILE="/tmp/n8n_env/env.sh"

echo "[n8n-entry] Waiting for ngrok config..."
while [ ! -f "$ENV_FILE" ]; do
  sleep 1
  echo "[n8-entry] Waiting for ngrok"
done

echo "[n8n-entry] Found $ENV_FILE, sourcing it..."
source "$ENV_FILE"

# Wait for MySQL to be ready
echo "[n8n-entry] Waiting for MySQL to be ready..."
until nc -z "$DB_MYSQLDB_HOST" "$DB_MYSQLDB_PORT"; do
  echo "[n8n-entry] MySQL is unavailable - sleeping"
  sleep 2
done
echo "[n8n-entry] MySQL is up - continuing"

# Install cheerio if not already installed
echo "[n8n-entry] Installing cheerio module if missing..."
cd /home/node/.n8n
if [ ! -d "node_modules/cheerio" ]; then
  echo "[n8n-entry] Installing npm dependencies..."
  [ -f "package.json" ] || echo '{ "name": "n8n-external-modules", "version": "1.0.0" }' > package.json
  npm install cheerio
fi

echo "[n8n-entry] Launching n8n with:"
echo "  - N8N_HOST=$N8N_HOST"
echo "  - N8N_PROTOCOL=$N8N_PROTOCOL"
echo "  - WEBHOOK_TUNNEL_URL=$WEBHOOK_TUNNEL_URL"

exec n8n
