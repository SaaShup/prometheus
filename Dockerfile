FROM prom/prometheus:v3.5.0
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY entrypoint.sh /entrypoint.sh

USER root
RUN chown -R 1000:1000 /prometheus /etc/prometheus

USER 1000

ENTRYPOINT ["/entrypoint.sh"]