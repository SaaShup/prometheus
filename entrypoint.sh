#!/bin/sh
set -e

mkdir -p /etc/prometheus/secrets/netbox-docker-agent

echo "$AGENT_BASIC_AUTH_USER" > /etc/prometheus/secrets/netbox-docker-agent/username
echo "$AGENT_BASIC_AUTH_PASSWORD" > /etc/prometheus/secrets/netbox-docker-agent/password

chown -R 1000:1000 /etc/prometheus/secrets

if [ -S /var/run/docker.sock ]; then
  DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
  GROUP_NAME=$(awk -F: -v gid="$DOCKER_GID" '$3 == gid { print $1; exit }' /etc/group)
  if [ -z "$GROUP_NAME" ]; then
    GROUP_NAME=dockersock
    addgroup -g "$DOCKER_GID" "$GROUP_NAME"
  fi
  addgroup prometheus "$GROUP_NAME" 2>/dev/null || true
fi

export PROM_ROUTE_PREFIX PROM_EXTERNAL_URL

exec su prometheus -c '
  exec /bin/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --web.route-prefix="$PROM_ROUTE_PREFIX" \
    --web.external-url="$PROM_EXTERNAL_URL"
'