# Enterprise AI Platform

A reference implementation for a secure, AI-driven, cloud-agnostic platform.

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