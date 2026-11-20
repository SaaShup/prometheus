FROM prom/prometheus:v3.5.0
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY entrypoint.sh /entrypoint.sh

USER root
RUN chmod +x /entrypoint.sh && \
    chown -R 1000:1000 /prometheus /etc/prometheus && \
    addgroup -g 1000 prometheus && \
    adduser -D -H -u 1000 -G prometheus prometheus

ENTRYPOINT ["/entrypoint.sh"]