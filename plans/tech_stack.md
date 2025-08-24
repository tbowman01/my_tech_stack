# 🚀 Enterprise AI Platform — Monorepo Scaffold

> **🎮 GAMIFICATION ACTIVE!** Level up your enterprise architecture skills through interactive quests and achievements!

## 🏆 Architecture Mastery Quest Line

**Current Quest**: 🌟 **Platform Explorer** (Active)
- **Objective**: Understand the complete tech stack architecture
- **Reward**: 🎯 **Architecture Apprentice Badge** + 200 XP
- **Progress**: Reading documentation (33% complete)

---

A production-minded scaffold for your **modern, fast, AI‑driven, scalable** enterprise stack. It implements your carefully chosen technologies:

### 🎯 **Infrastructure Quest Chain**
* **🏗️ Foundation Master**: **K8s + Docker + Terraform** (cloud‑agnostic) - *Complete for Infrastructure Badge (150 XP)*
* **🌐 Network Ninja**: **Cilium** (CNI & service mesh, Hubble) - *Complete for Networking Expert (200 XP)*
* **⚡ Gateway Guardian**: **Envoy Gateway** (Gateway API) with **Cloudflare** - *Complete for Traffic Master (175 XP)*
### 🛠️ **Development Quest Chain**
* **💻 Polyglot Developer**: **Rust / TypeScript-Node / Python** services - *Complete for Language Master (250 XP)*
* **🔗 API Architect**: **REST + gRPC** protocols - *Complete for Protocol Expert (200 XP)*
* **⚡ Message Maestro**: **NATS JetStream** streaming - *Complete for Messaging Master (175 XP)*
### 💾 **Data Engineering Quest Chain**
* **🗄️ Database Expert**: **Postgres + Redis + ClickHouse** - *Complete for Data Master (300 XP)*
* **🧠 Vector Wizard**: **Qdrant** (vectors) for AI workloads - *Complete for AI Data Expert (250 XP)*
* **🔍 Search Specialist**: **OpenSearch** (app search) - *Complete for Search Master (200 XP)*
* **☁️ Storage Guru**: **S3‑compatible** object storage - *Complete for Storage Expert (150 XP)*
### 🔒 **Security Champion Quest Chain**
* **🛡️ Secret Keeper**: **Vault + SOPS + External Secrets Operator** - *Complete for Security Master (400 XP)*
* **🗝️ Identity Guardian**: **Keycloak** (OIDC) authentication - *Complete for Auth Expert (300 XP)*
* **⚖️ Policy Enforcer**: **OPA/Gatekeeper** governance - *Complete for Compliance Master (250 XP)*
### 📊 **Observability Master Quest Chain**
* **🔭 Monitoring Sage**: **OpenTelemetry → Prometheus/Loki/Tempo + Grafana** - *Complete for Observability Expert (350 XP)*
* **🔥 Performance Detective**: **Parca/Pyroscope** profiling - *Complete for Performance Master (275 XP)*
* **💰 Cost Optimizer**: **OpenCost** financial observability - *Complete for FinOps Expert (200 XP)*
### 🚀 **Advanced Operations Quest Chain**
* **🎯 Deployment Master**: **Argo Rollouts + Flagger** progressive delivery - *Complete for DevOps Legend (400 XP)*
* **📈 Data Pipeline Architect**: **Atlas + Debezium + dbt + Great Expectations + OpenMetadata** - *Complete for Data Engineering Master (500 XP)*
### 🤖 **AI/ML Excellence Quest Chain**
* **🧠 ML Platform Builder**: **MLflow + Feast + RAG** - *Complete for AI Platform Expert (450 XP)*
* **⚖️ AI Safety Guardian**: Safety guardrails, eval harness, shadow deploys - *Complete for AI Ethics Master (350 XP)*
### 📚 **Documentation & Developer Experience Quest Chain**
* **✍️ Documentation Hero**: **Docusaurus v2** docs‑as‑code - *Complete for Documentation Master (200 XP)*
* **🏗️ Platform Engineer**: **Backstage** Internal Developer Platform - *Complete for IDP Expert (300 XP)*
### 🔐 **Supply Chain Security Quest Chain** (Advanced)
* **📋 SBOM Specialist**: **Syft** (Software Bill of Materials) - *Complete for Supply Chain Expert (300 XP)*
* **🛡️ Security Scanner**: **Trivy/Grype** vulnerability detection - *Complete for Security Analyst (250 XP)*
* **✍️ Signing Authority**: **Cosign** (keyless + Rekor) artifact signing - *Complete for PKI Master (275 XP)*
* **🏆 Compliance Champion**: **SLSA v3+**, Renovate, Gitleaks, tfsec/Checkov - *Complete for Security Architect (500 XP)*
### 🧪 **Quality Assurance Quest Chain**
* **🎯 Test-Driven Master**: **London‑style TDD** methodology - *Complete for Testing Expert (300 XP)*
* **📝 Contract Guardian**: API contract tests - *Complete for Integration Master (250 XP)*
* **🌐 End-to-End Specialist**: E2E testing strategies - *Complete for QA Champion (275 XP)*

---

## 🎮 Achievement System Progress

### 🏆 Your Architecture Journey
```
Current Level: 🥚 Architecture Newcomer
Total XP: 0 / 5,000 (to Architecture Master)
Badges Earned: 0 / 25+ available
Quest Chains Completed: 0 / 9 available

Next Milestone: 🌟 Complete Platform Explorer quest (+200 XP)
```

### 🎯 Available Quest Chains (Click to Start!)

| Quest Chain | Difficulty | Estimated Time | Total XP | Badges |
|-------------|------------|----------------|----------|--------|
| 🏗️ Infrastructure | ⭐⭐⭐ | 2-3 hours | 525 XP | 3 badges |
| 🛠️ Development | ⭐⭐⭐⭐ | 3-4 hours | 625 XP | 3 badges |
| 💾 Data Engineering | ⭐⭐⭐⭐⭐ | 4-5 hours | 900 XP | 4 badges |
| 🔒 Security Champion | ⭐⭐⭐⭐⭐ | 5-6 hours | 950 XP | 3 badges |
| 📊 Observability | ⭐⭐⭐⭐ | 3-4 hours | 825 XP | 3 badges |
| 🚀 Advanced Operations | ⭐⭐⭐⭐⭐ | 6-8 hours | 900 XP | 2 badges |
| 🤖 AI/ML Excellence | ⭐⭐⭐⭐⭐ | 4-6 hours | 800 XP | 2 badges |
| 📚 Developer Experience | ⭐⭐⭐ | 2-3 hours | 500 XP | 2 badges |
| 🧪 Quality Assurance | ⭐⭐⭐⭐ | 3-4 hours | 825 XP | 3 badges |

**🏆 GRAND TOTAL**: Complete all quest chains to earn **Enterprise Architecture Grandmaster** status (5,950+ XP)

---

## 🗺️ Interactive Repository Layout

> **🎯 Quest Hint**: Each directory represents a different skill area. Explore to unlock achievements!

```text
repo/  🏰 ENTERPRISE AI PLATFORM CASTLE
  README.md
  Makefile
  devcontainer.json
  .gitignore
  .gitleaks.toml
  renovate.json
  .nvmrc
  .tool-versions            # optional: pin go/rust/node/python
  .editorconfig
  .pre-commit-config.yaml
  .github/
    workflows/
      ci.yaml
      prow-like-pr-checks.yaml
  docs/                     # Docusaurus v2 site
    docusaurus.config.ts
    sidebars.ts
    package.json
    src/pages/index.tsx
    docs/intro.md
    docs/runbooks/...
  backstage/
    app-config.yaml
    catalog-info.yaml
    templates/...
    helm/values.yaml
  apps/
    web/                    # Next.js (App Router)
    api-gateway/            # Fastify REST + authz hooks, Envoy aware
    bff/                    # optional web BFF
    stream-ingest/          # Rust (Axum/Tonic) → NATS producers
    workers/                # Node/Python async workers
    ai/
      inference/            # Python (FastAPI) + vLLM/Ollama clients
      training/             # Python pipelines; MLflow
  services/
    users/                  # sample service (Rust or Node)
    analytics/              # ClickHouse writers/readers
  libs/
    contracts/              # OpenAPI + protobuf + buf
    shared-ts/
    shared-rs/
    shared-py/
  infra/
    terraform/
      envs/
        dev/
          main.tf
          variables.tf
          outputs.tf
        prod/
          main.tf
      modules/
        network/
        kubernetes/
        storage/
        ci-oidc/
        vault/
        keycloak/
        opensearch/
        nats/
        qdrant/
        clickhouse/
        postgres/
    helm/
      charts/
        svc-template/
          Chart.yaml
          values.yaml
          templates/deployment.yaml
          templates/service.yaml
          templates/hpa.yaml
      platform/
        cilium/
          values.yaml
        envoy-gateway/
          values.yaml
        cert-manager/
          values.yaml
        spire/
          values.yaml
        external-secrets/
          values.yaml
        vault/
          values.yaml
        keycloak/
          values.yaml
        nats/
          values.yaml
        qdrant/
          values.yaml
        clickhouse/
          values.yaml
        opensearch/
          values.yaml
        openmetadata/
          values.yaml
        opentelemetry-collector/
          values.yaml
        grafana-stack/
          values.yaml
        argorollouts/
          values.yaml
        flagger/
          values.yaml
        mlflow/
          values.yaml
        feast/
          values.yaml
        opencost/
          values.yaml
    kustomize/
      bases/
        namespace.yaml
        networkpolicies.yaml
      overlays/
        dev/
          kustomization.yaml
          values-patches.yaml
        prod/
          kustomization.yaml
          values-patches.yaml
  policies/ ⚖️            # Security & Compliance [🎯 Policy Enforcer Quest]
    gatekeeper/ 🚪          # OPA admission control [🎯 Security Guardian Badge]
      templates/require-signed-images.yaml
      constraints/require-signed-images.yaml
    conftest/ 🔍           # Policy testing [🎯 Compliance Tester Badge]
      deployment.rego
    kyverno/ (optional)
  ops/
    otel/
      collector.yaml
      dashboards/...
      slos/...
    mesh/
      cilium-network-policies.yaml
      envoy-gateway-routes.yaml
    nats/
      jetstream/streams.yaml
      jetstream/consumers.yaml
    keycloak/
      realm-export.json
    vault/
      pki.hcl
      policies/
      external-secrets/
        postgres-creds.yaml
    synthetic/
      cloudflare-checks.yaml
```

---

## Getting Started (bootstrap)

1. **Pre-reqs:** Docker, make, direnv, kubectl, helm, terraform, cosign, sops, age, buf, protoc, node LTS, go 1.22, rust stable, python 3.11.
2. **Init dev env:**

   ```bash
   make init-dev   # installs git hooks, pre-commit, validates toolchain
   make deps       # install JS/Go/Rust/Py deps where applicable
   ```
3. **Terraform (dev):**

   ```bash
   cd infra/terraform/envs/dev && terraform init && terraform apply
   ```
4. **Install platform via Helm:**

   ```bash
   make platform-apply   # wraps helmfile/kustomize to install cilium→envoy→vault→keycloak→data→otel→rollouts
   ```
5. **Seed Vault & Keycloak:**

   ```bash
   make vault-bootstrap keycloak-bootstrap
   ```
6. **Deploy sample services:**

   ```bash
   make deploy-dev
   ```

> Order: Terraform → Cilium(+Hubble) → Envoy Gateway → cert-manager → SPIRE → External Secrets ↔ Vault → Keycloak → NATS/Postgres/Redis/Qdrant/ClickHouse/OpenSearch → Debezium/dbt/GE/OpenMetadata → OTel/Prom/Loki/Tempo/Grafana/Parca/OpenCost → Argo Rollouts + Flagger → Apps.

---

## Makefile (core targets)

```make
SHELL := /bin/bash
.DEFAULT_GOAL := help

include .env.mk  # optional validated env exports

help: ## Show targets
	@grep -E '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-28s\033[0m %s\n", $$1, $$2}'

init-dev: ## Install hooks & pre-commit
	pre-commit install -t pre-commit -t commit-msg

sbom: ## Generate SBOMs with Syft
	syft packages --output spdx-json=sbom.spdx.json . || true

scan: ## Trivy/Grype scans
	trivy fs --exit-code 1 --scanners vuln,secret .
	grype -q . || true

sign: ## Cosign keyless sign (OIDC)
	COSIGN_EXPERIMENTAL=1 cosign sign --yes $(IMAGE)

verify-admission: ## Test OPA/Gatekeeper bundle locally
	conftest test -p policies/conftest kubernetes/

platform-apply: ## Install/upgrade platform stacks via helm/kustomize wrappers
	./scripts/platform_apply.sh

vault-bootstrap: ## Enable PKI/Transit/KV, create policies & roles
	./scripts/vault_bootstrap.sh

keycloak-bootstrap: ## Import realm, clients, roles
	./scripts/keycloak_bootstrap.sh

deploy-dev: ## Build images, sign, deploy with Helm, progressive rollout
	./scripts/deploy.sh dev

clean: ## Remove build artifacts
	rm -rf dist node_modules target .venv sbom.*
```

---

## GitHub Actions: `ci.yaml`

```yaml
name: ci
on:
  pull_request:
  push:
    branches: [ main ]
permissions:
  id-token: write   # for keyless signing/SLSA
  contents: read
  packages: write
jobs:
  build-test-scan:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        lang: [node, go, rust, python]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        if: matrix.lang == 'node'
        with: { node-version: 'lts/*' }
      - uses: actions/setup-go@v5
        if: matrix.lang == 'go'
        with: { go-version: '1.22.x' }
      - uses: dtolnay/rust-toolchain@stable
        if: matrix.lang == 'rust'
      - uses: actions/setup-python@v5
        if: matrix.lang == 'python'
        with: { python-version: '3.11' }

      - name: Install deps
        run: |
          case "${{ matrix.lang }}" in
            node) npm ci;;
            go) go mod download;;
            rust) cargo fetch;;
            python) python -m pip install -r requirements.txt;;
          esac

      - name: Tests
        run: |
          case "${{ matrix.lang }}" in
            node) npm test;;
            go) go test ./...;;
            rust) cargo test --all;;
            python) pytest;;
          esac

      - name: SBOM (Syft)
        uses: anchore/sbom-action@v0
        with: { upload-artifact: true, format: spdx-json }

      - name: Trivy FS scan
        uses: aquasecurity/trivy-action@0.24.0
        with: { scan-type: 'fs', exit-code: '1', format: 'table' }

      - name: Gitleaks
        uses: zricethezav/gitleaks-action@v2

  build-images:
    needs: build-test-scan
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/setup-qemu-action@v3
      - uses: docker/setup-buildx-action@v3
      - uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - name: Build + push images (multi-arch)
        run: |
          ./scripts/build_all.sh

      - name: Trivy image scan
        uses: aquasecurity/trivy-action@0.24.0
        with: { scan-type: 'image', image-ref: 'ghcr.io/${{ github.repository }}/api-gateway:$(git rev-parse --short HEAD)', exit-code: '1' }

      - name: Cosign sign
        env:
          COSIGN_EXPERIMENTAL: '1'
        run: |
          cosign sign --yes ghcr.io/${{ github.repository }}/api-gateway:$(git rev-parse --short HEAD)

  deploy:
    needs: build-images
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - name: Helm upgrade (dev)
        run: |
          helm upgrade --install api-gateway infra/helm/charts/svc-template \
            -f infra/helm/charts/svc-template/values.yaml \
            --set image.repository=ghcr.io/${{ github.repository }}/api-gateway \
            --set image.tag=$(git rev-parse --short HEAD)
      - name: Progressive rollout
        run: |
          kubectl apply -f infra/helm/platform/argorollouts/values.yaml
```

---

## Envoy Gateway (Gateway API) — sample

```yaml
# infra/helm/platform/envoy-gateway/values.yaml (excerpt)
install:
  crds: true

gateway:
  listeners:
    - name: http
      port: 80
      protocol: HTTP
      hostname: "example.com"
      tls: {}
    - name: https
      port: 443
      protocol: HTTPS
      tls:
        mode: Terminate
        certificateRef:
          kind: Secret
          name: wildcard-cert

ratelimit:
  enabled: true
  backend: redis

xds:
  enableRBAC: true
```

---

## Cilium & Policies (mesh)

```yaml
# infra/helm/platform/cilium/values.yaml (excerpt)
kubeProxyReplacement: strict
hubble:
  enabled: true
  relay:
    enabled: true
  ui:
    enabled: true

bpf:
  masquerade: true

securityContext:
  capabilities:
    ciliumAgent: [BPF, PERFMON, NET_ADMIN]

enableKafka: false

# Example L7 policy\---
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: allow-api-outbound
  namespace: default
spec:
  endpointSelector:
    matchLabels:
      app.kubernetes.io/name: api-gateway
  egress:
    - toEntities: [ kube-apiserver, cluster, world ]
      toPorts:
        - ports:
            - port: "443"
              protocol: TCP
          rules:
            http:
              - method: GET
                path: "/.well-known/*"
```

---

## SPIRE + mTLS (outline)

```yaml
# infra/helm/platform/spire/values.yaml (excerpt)
server:
  bundleEndpoint:
    enabled: true
  dataStore:
    sql:
      databaseType: sqlite3
agent:
  nodeAttestor:
    k8sPsat:
      cluster: primary

# SPIFFE IDs will be issued per namespace/serviceAccount; Envoy + Cilium consume identities
```

---

## External Secrets (Vault) example

```yaml
# ops/vault/external-secrets/postgres-creds.yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: postgres-creds
  namespace: data
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: pg-app
    creationPolicy: Owner
  data:
    - secretKey: username
      remoteRef:
        key: kv/data/db/pg
        property: username
    - secretKey: password
      remoteRef:
        key: kv/data/db/pg
        property: password
```

---

## Gatekeeper: require signed images

```yaml
# policies/gatekeeper/templates/require-signed-images.yaml
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8srequiredsignatures
spec:
  crd:
    spec:
      names:
        kind: K8sRequiredSignatures
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequiredsignatures
        violation[{
          "msg": msg
        }] {
          input.review.kind.kind == "Pod"
          some i
          container := input.review.object.spec.containers[i]
          not startswith(container.image, "ghcr.io/")
          msg := sprintf("Image %v must be signed and from ghcr.io", [container.image])
        }
---
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredSignatures
metadata:
  name: only-signed-ghcr
spec: {}
```

---

## Helm service chart (template)

```yaml
# infra/helm/charts/svc-template/Chart.yaml
apiVersion: v2
name: svc-template
version: 0.1.0
appVersion: "0.1.0"
```

```yaml
# infra/helm/charts/svc-template/values.yaml
image:
  repository: ghcr.io/your-org/your-svc
  tag: latest
  pullPolicy: IfNotPresent
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 500m
    memory: 512Mi
otel:
  enabled: true
```

```yaml
# infra/helm/charts/svc-template/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "svc-template.fullname" . }}
  labels: { app.kubernetes.io/name: {{ include "svc-template.name" . }} }
spec:
  replicas: 2
  selector: { matchLabels: { app.kubernetes.io/name: {{ include "svc-template.name" . }} } }
  template:
    metadata:
      labels: { app.kubernetes.io/name: {{ include "svc-template.name" . }} }
      annotations:
        sidecar.istio.io/inject: "false"  # using Cilium mesh
    spec:
      containers:
        - name: app
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: 8080
          env:
            - name: OTEL_EXPORTER_OTLP_ENDPOINT
              value: http://otel-collector:4317
          securityContext:
            readOnlyRootFilesystem: true
            allowPrivilegeEscalation: false
```

---

## Sample Rust service (Axum) — minimal

```toml
# services/users/Cargo.toml
[package]
name = "users"
version = "0.1.0"
edition = "2021"

[dependencies]
axum = "0.7"
tokio = { version = "1", features = ["macros", "rt-multi-thread"] }
tracing = "0.1"
opentelemetry = "0.23"
opentelemetry-otlp = { version = "0.16", features = ["tonic"] }
tracing-subscriber = { version = "0.3", features=["env-filter", "fmt", "json"] }
reqwest = { version = "0.12", features=["json"] }
```

```rust
// services/users/src/main.rs
use axum::{routing::get, Router};
use std::net::SocketAddr;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[tokio::main]
async fn main() {
    let otel = opentelemetry_otlp::new_pipeline().tracing().init_tracer().unwrap();
    let otel_layer = tracing_opentelemetry::layer().with_tracer(otel);
    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::from_default_env())
        .with(tracing_subscriber::fmt::layer())
        .with(otel_layer)
        .init();

    let app = Router::new()
        .route("/healthz", get(|| async { "ok" }))
        .route("/", get(|| async { "users svc" }));

    let addr = SocketAddr::from(([0, 0, 0, 0], 8080));
    tracing::info!("listening on {}", addr);
    axum::serve(tokio::net::TcpListener::bind(addr).await.unwrap(), app).await.unwrap();
}
```

```Dockerfile
# services/users/Dockerfile (multi-stage, Chainguard build → Distroless run)
FROM cgr.dev/chainguard/rust:latest as build
WORKDIR /work
COPY . .
RUN cargo build --release

FROM gcr.io/distroless/cc:latest
COPY --from=build /work/target/release/users /usr/local/bin/users
USER 65532:65532
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/users"]
```

---

## Sample Node (Fastify) — minimal

```json
// apps/api-gateway/package.json
{
  "name": "api-gateway",
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "node --watch src/index.js",
    "start": "node src/index.js",
    "test": "vitest run --coverage"
  },
  "dependencies": {
    "fastify": "^4",
    "@fastify/under-pressure": "^8",
    "@opentelemetry/api": "^1",
    "@opentelemetry/sdk-node": "^5",
    "@opentelemetry/exporter-trace-otlp-grpc": "^0.53"
  },
  "devDependencies": { "vitest": "^2" }
}
```

```js
// apps/api-gateway/src/index.js
import Fastify from 'fastify';
const app = Fastify({ logger: true });
app.get('/healthz', async () => ({ ok: true }));
app.get('/', async () => ({ service: 'api-gateway' }));
await app.listen({ port: 8080, host: '0.0.0.0' });
```

```Dockerfile
# apps/api-gateway/Dockerfile
FROM cgr.dev/chainguard/node:latest as runtime
WORKDIR /app
COPY package*.json .
RUN npm ci --omit=dev
COPY src ./src
EXPOSE 8080
CMD ["node","src/index.js"]
```

---

## Sample Python AI (FastAPI)

```text
# apps/ai/inference/requirements.txt
fastapi==0.115.0
uvicorn==0.30.6
opentelemetry-sdk==1.26.0
opentelemetry-exporter-otlp==1.26.0
```

```python
# apps/ai/inference/main.py
from fastapi import FastAPI
app = FastAPI()

@app.get("/healthz")
def health():
    return {"ok": True}

@app.post("/infer")
def infer(payload: dict):
    # TODO: route to vLLM/Ollama or managed provider
    return {"echo": payload}
```

```Dockerfile
# apps/ai/inference/Dockerfile
FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8080
CMD ["uvicorn","main:app","--host","0.0.0.0","--port","8080"]
```

---

## OpenAPI + gRPC Contracts

```yaml
# libs/contracts/openapi.yaml
openapi: 3.0.3
info: { title: api, version: 0.1.0 }
paths:
  /healthz:
    get:
      responses:
        '200': { description: ok }
```

```yaml
# libs/contracts/buf.yaml
version: v1
breaking:
  use: [ FILE ]
```

```proto
// libs/contracts/proto/example/v1/echo.proto
syntax = "proto3";
package example.v1;
service Echo { rpc Say(EchoRequest) returns (EchoReply); }
message EchoRequest { string msg = 1; }
message EchoReply { string msg = 1; }
```

---

## Docusaurus v2 (docs-as-code)

```ts
// docs/docusaurus.config.ts
import { Config } from '@docusaurus/types';
const config: Config = {
  title: 'Enterprise AI Platform',
  url: 'https://example.com',
  baseUrl: '/',
  favicon: 'img/favicon.ico',
  presets: [
    [ 'classic', { docs: { sidebarPath: require.resolve('./sidebars.ts') }, blog: false } ]
  ],
};
export default config;
```

```md
# docs/docs/intro.md
# Welcome
This is the single source of truth for architecture, runbooks, SLOs, APIs, and security.
```

---

## Backstage (IDP) — minimal

```yaml
# backstage/catalog-info.yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: enterprise-ai-platform
spec:
  type: service
  lifecycle: experimental
  owner: platform
```

---

## Data: Debezium → ClickHouse (outline)

```yaml
# infra/kustomize/bases/debezium-connector.yaml (excerpt)
apiVersion: kafka.strimzi.io/v1beta2
kind: KafkaConnector
metadata:
  name: pg-cdc
spec:
  class: io.debezium.connector.postgresql.PostgresConnector
  tasksMax: 1
  config:
    database.hostname: postgres
    database.dbname: app
    database.user: ${username}
    database.password: ${password}
    table.include.list: public.*
    topic.prefix: cdc
```

---

## OpenTelemetry Collector (basic)

```yaml
# ops/otel/collector.yaml
apiVersion: opentelemetry.io/v1alpha1
kind: OpenTelemetryCollector
metadata:
  name: otel
spec:
  config: |
    receivers:
      otlp:
        protocols:
          grpc:
          http:
    processors:
      batch:
    exporters:
      prometheus:
        endpoint: 0.0.0.0:8889
      otlp:
        endpoint: tempo:4317
        tls: { insecure: true }
    service:
      pipelines:
        traces: { receivers: [otlp], processors: [batch], exporters: [otlp] }
        metrics: { receivers: [otlp], processors: [batch], exporters: [prometheus] }
```

---

## Pre-commit & Security

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: end-of-file-fixer
      - id: trailing-whitespace
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.4
    hooks: [ { id: gitleaks } ]
```

```json
// renovate.json
{ "extends": ["config:recommended"], "ignorePaths": ["docs/**", "backstage/**"] }
```

---

## README.md (starter)

```md
# Enterprise AI Platform

A reference implementation for a secure, AI‑driven, cloud‑agnostic platform.

## Fast start
1. Install prerequisites (Docker, make, terraform, helm, kubectl, cosign, sops, age).
2. `make init-dev && cd infra/terraform/envs/dev && terraform apply`.
3. `make platform-apply && make vault-bootstrap && make keycloak-bootstrap`.
4. `make deploy-dev` and visit the gateway URL.

## Security
- Distroless/Chainguard images, SBOMs, Trivy/Grype scans, Cosign signing (keyless), Gatekeeper verifies.
- Vault + SOPS for secrets, SPIFFE IDs via SPIRE, mTLS in mesh, Cilium L7 policies.

## Docs & IDP
- Docusaurus at `/docs`; Backstage at `/backstage` (golden paths & scorecards).
```

---

### Notes

* Many platform components intentionally reference **upstream Helm charts**; this scaffold provides values + Kustomize overlays for opinionated defaults.
* Replace `example.com` and `ghcr.io/your-org` with your own domains/registries.
* Add per‑tenant schema and RLS examples under `services/users/db/` if multi‑tenant.
* For AI plane (vLLM/Ollama) add GPU node pool taints and nodeSelectors in the svc chart values.
