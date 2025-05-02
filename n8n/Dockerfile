FROM n8nio/n8n:latest

# Switch to root to change permissions
USER root
COPY custom-entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh

# Switch back to the node user
USER node

ENTRYPOINT ["/custom-entrypoint.sh"]

