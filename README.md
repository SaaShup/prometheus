
# Prometheus Docker image for SaaShup

Prometheus configuration using Docker Service Discovery.

Automatically discovers containers to scrape based on labels on the same host.

---

## Usage

Build:

```bash
docker build -t saashup/prometheus:latest .
```

Run:

```bash
docker run -d \
  -p 9090:9090 \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  saashup/prometheus:latest
```

Open:

```
http://localhost:9090
```

---

## Configuration

The container supports the following environment variables:

- `AGENT_BASIC_AUTH_USER`: Username for basic authentication (default: none)
- `AGENT_BASIC_AUTH_PASSWORD`: Password for basic authentication (default: none)
- `PROM_ROUTE_PREFIX`: Route prefix for Prometheus web UI (default: /)
- `PROM_EXTERNAL_URL`: External URL for Prometheus (default: none)

---

## How it works

Prometheus reads Docker containers via:

```
/var/run/docker.sock
```

Only containers with:

```
prometheus_scrape=true
```

are monitored.

Each container must define:

```
prometheus_port=<host>:<port>
```

Additionally, you can specify a custom metrics path using the label:

```
prometheus_path=/custom-metrics
```
by default is /metrics.

---

## Example

```yaml
labels:
  - "prometheus_scrape=true"
  - "prometheus_port=traefik:8081"
```

---

## Notes

* Metrics path format must be Prometheus (text, not JSON)