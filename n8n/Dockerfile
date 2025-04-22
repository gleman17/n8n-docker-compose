FROM n8nio/n8n:latest

COPY custom-entrypoint.sh /custom-entrypoint.sh

RUN echo "Build context contains:" && ls -l && \
    echo "Entrypoint content:" && cat /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
