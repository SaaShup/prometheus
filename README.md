
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

---

## Example

```yaml
labels:
  - "prometheus_scrape=true"
  - "prometheus_port=traefik:8081"
```

---

## Notes

* Targets must expose `/metrics`
* Format must be Prometheus (text, not JSON)