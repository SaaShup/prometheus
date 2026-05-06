#!/bin/sh
set -e

mkdir -p /etc/prometheus/secrets/netbox-docker-agent

echo "$AGENT_BASIC_AUTH_USER" > /etc/prometheus/secrets/netbox-docker-agent/username
echo "$AGENT_BASIC_AUTH_PASSWORD" > /etc/prometheus/secrets/netbox-docker-agent/password

exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.route-prefix="${PROM_ROUTE_PREFIX}" \
  --web.external-url="${PROM_EXTERNAL_URL}"