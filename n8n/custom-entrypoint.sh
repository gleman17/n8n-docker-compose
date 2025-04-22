#!/bin/sh

# Load dynamic environment from ngrok
ENV_FILE="/tmp/n8n_env/env.sh"

echo "[n8n-entry] Waiting for ngrok config..."

while [ ! -f "$ENV_FILE" ]; do
  sleep 1
done

echo "[n8n-entry] Found $ENV_FILE, sourcing it..."
source "$ENV_FILE"

echo "[n8n-entry] Launching n8n with:"
echo "  - N8N_HOST=$N8N_HOST"
echo "  - N8N_PROTOCOL=$N8N_PROTOCOL"
echo "  - WEBHOOK_TUNNEL_URL=$WEBHOOK_TUNNEL_URL"

exec n8n
