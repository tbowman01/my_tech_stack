# 🛡️ Security Champion Quest: Guardian of the Platform

Welcome, aspiring Security Champion! This quest will transform you into a master of enterprise security. Protect your platform from threats while enabling seamless operations.

## 🎯 Quest Overview

**Difficulty**: ⭐⭐⭐ Intermediate  
**Duration**: 2-3 hours  
**Prerequisites**: Complete [Tutorial Quest](/docs/quests/getting-started)  
**XP Reward**: 300 XP  

:::tip 🌟 **Quest Bonus**
Complete all achievements to unlock the legendary **"Security Champion"** title and special security badge!
:::

## 🏆 Achievement Tree

```mermaid
flowchart TD
    START([🛡️ Security Champion<br/>Quest Start]) --> A1[🆔 Identity Master]
    START --> A2[🔐 Vault Keeper] 
    START --> A3[📋 Policy Guardian]
    
    A1 --> B1[🔒 mTLS Expert]
    A1 --> B2[🎫 JWT Specialist]
    
    A2 --> B3[🗝️ Secret Rotator]
    A2 --> B4[🔑 Key Manager]
    
    A3 --> B5[🚨 Threat Detector]
    A3 --> B6[🛡️ Policy Enforcer]
    
    B1 --> FINAL[🏆 Security Champion<br/>Master Achievement]
    B3 --> FINAL
    B5 --> FINAL
    
    click A1 "#identity-master" "Start Identity Mastery"
    click A2 "#vault-keeper" "Begin Vault Mastery"
    click A3 "#policy-guardian" "Learn Policy Enforcement"
```

---

## 🆔 Achievement 1: Identity Master

Master SPIFFE/SPIRE identity management - the foundation of zero-trust security.

### 🎯 Learning Objectives

- Understand SPIFFE identity framework
- Deploy and configure SPIRE agents
- Issue and validate identity certificates
- Implement workload attestation

### 🚀 Hands-On Lab: SPIRE Identity

#### Step 1: Explore SPIRE Architecture

```bash
# View SPIRE components
kubectl get pods -n spire-system

# Check SPIRE server status
kubectl logs -n spire-system spire-server-0

# Examine SPIRE agent configuration
kubectl describe daemonset -n spire-system spire-agent
```

#### Step 2: Identity Registration

```bash
# Register a new workload identity
kubectl exec -n spire-system spire-server-0 -- \
  /opt/spire/bin/spire-server entry create \
  -parentID spiffe://platform.local/agent \
  -spiffeID spiffe://platform.local/user-service \
  -selector k8s:deployment:user-service

# View registered identities
kubectl exec -n spire-system spire-server-0 -- \
  /opt/spire/bin/spire-server entry show
```

#### Step 3: Certificate Validation

```bash
# Get workload certificate
kubectl exec -n spire-system spire-agent-abc123 -- \
  /opt/spire/bin/spire-agent api fetch

# Verify certificate details
openssl x509 -in certificate.pem -text -noout
```

:::challenge 🎯 **Challenge: Custom Identity**
Create a custom SPIFFE ID for a new microservice. Configure selectors based on both namespace and service account.
:::

### ✅ Identity Master Checkpoints

- [ ] **SPIRE Architecture**: Understand server/agent roles (20 XP)
- [ ] **Identity Registration**: Register workload identities (25 XP)
- [ ] **Certificate Management**: Issue and rotate certificates (25 XP)
- [ ] **Attestation Policies**: Configure workload attestation (30 XP)

:::success 🎉 **Achievement Unlocked!**
**🆔 Identity Master** - You've mastered SPIFFE/SPIRE identity management!  
**+100 XP** | **Special Reward**: Identity Management Cheat Sheet
:::

---

## 🔐 Achievement 2: Vault Keeper

Become the guardian of secrets with HashiCorp Vault mastery.

### 🎯 Learning Objectives

- Deploy and unseal Vault
- Configure authentication methods
- Manage secrets and policies
- Implement secret rotation

### 🚀 Hands-On Lab: Vault Mastery

#### Step 1: Vault Initialization

```bash
# Check Vault status
kubectl exec vault-0 -- vault status

# Initialize Vault (if needed)
kubectl exec vault-0 -- vault operator init

# Unseal Vault
kubectl exec vault-0 -- vault operator unseal <unseal-key>
```

#### Step 2: Authentication Setup

```bash
# Enable Kubernetes auth
kubectl exec vault-0 -- vault auth enable kubernetes

# Configure Kubernetes auth
kubectl exec vault-0 -- vault write auth/kubernetes/config \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

#### Step 3: Secret Management

```bash
# Create secret engine
kubectl exec vault-0 -- vault secrets enable -path=app-secrets kv-v2

# Store application secrets
kubectl exec vault-0 -- vault kv put app-secrets/user-service \
  db_password="super-secret-password" \
  api_key="abc123xyz789"

# Read secrets
kubectl exec vault-0 -- vault kv get app-secrets/user-service
```

#### Step 4: Policy Creation

Create a Vault policy for your service:

```bash
# Create policy file
cat <<EOF > user-service-policy.hcl
path "app-secrets/data/user-service" {
  capabilities = ["read"]
}

path "database/creds/user-service" {
  capabilities = ["read"]
}
EOF

# Apply policy
kubectl cp user-service-policy.hcl vault-0:/tmp/
kubectl exec vault-0 -- vault policy write user-service /tmp/user-service-policy.hcl
```

### 🔄 Secret Rotation Lab

```bash
# Enable database engine
kubectl exec vault-0 -- vault secrets enable database

# Configure PostgreSQL connection
kubectl exec vault-0 -- vault write database/config/postgresql \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@postgres:5432/app?sslmode=disable" \
  allowed_roles="user-service" \
  username="root" \
  password="rootpassword"

# Create role for dynamic secrets
kubectl exec vault-0 -- vault write database/roles/user-service \
  db_name=postgresql \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  default_ttl="1h" \
  max_ttl="24h"
```

:::tip 💡 **Pro Tip: External Secrets**
Use External Secrets Operator to automatically sync Vault secrets to Kubernetes secrets!
:::

### ✅ Vault Keeper Checkpoints

- [ ] **Vault Deployment**: Deploy and configure Vault (25 XP)
- [ ] **Authentication**: Set up Kubernetes auth method (20 XP)
- [ ] **Secret Storage**: Store and retrieve secrets (25 XP)
- [ ] **Policy Management**: Create and apply policies (25 XP)
- [ ] **Dynamic Secrets**: Configure database secret rotation (30 XP)

:::success 🎉 **Achievement Unlocked!**
**🔐 Vault Keeper** - You've mastered HashiCorp Vault!  
**+125 XP** | **Special Reward**: Vault Best Practices Guide
:::

---

## 📋 Achievement 3: Policy Guardian

Master policy-as-code with Open Policy Agent (OPA) and Gatekeeper.

### 🎯 Learning Objectives

- Understand OPA/Rego language
- Deploy Gatekeeper for admission control
- Write custom constraint templates
- Monitor policy violations

### 🚀 Hands-On Lab: Policy Enforcement

#### Step 1: OPA Introduction

```bash
# Check Gatekeeper installation
kubectl get pods -n gatekeeper-system

# View existing constraint templates
kubectl get constrainttemplates

# View active constraints
kubectl get constraints
```

#### Step 2: Write Your First Policy

Create a policy to require resource limits:

```yaml
# resource-limits-template.yaml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8srequireresourcelimits
spec:
  crd:
    spec:
      names:
        kind: K8sRequireResourceLimits
      validation:
        properties:
          exemptImages:
            type: array
            items:
              type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequireresourcelimits

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not container.resources.limits.memory
          msg := sprintf("Container <%v> is missing memory limits", [container.name])
        }

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not container.resources.limits.cpu
          msg := sprintf("Container <%v> is missing CPU limits", [container.name])
        }
```

#### Step 3: Apply and Test Policy

```bash
# Apply constraint template
kubectl apply -f resource-limits-template.yaml

# Create constraint instance
cat <<EOF | kubectl apply -f -
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequireResourceLimits
metadata:
  name: must-have-limits
spec:
  match:
    kinds:
      - apiGroups: ["apps"]
        kinds: ["Deployment"]
    namespaces: ["default"]
EOF

# Test policy violation
kubectl run test-pod --image=nginx  # Should fail!

# Test compliant deployment
kubectl run compliant-pod --image=nginx \
  --limits=memory=256Mi,cpu=100m  # Should succeed!
```

#### Step 4: Security Policies

```yaml
# disallow-privileged-template.yaml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8sdisallowprivileged
spec:
  crd:
    spec:
      names:
        kind: K8sDisallowPrivileged
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sdisallowprivileged

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          container.securityContext.privileged
          msg := "Privileged containers are not allowed"
        }
```

### 📊 Policy Monitoring

```bash
# View policy violations
kubectl get events --field-selector reason=FailedAdmission

# Check constraint status
kubectl describe k8srequireresourcelimits must-have-limits

# View Gatekeeper audit logs
kubectl logs -n gatekeeper-system deployment/gatekeeper-audit
```

:::challenge 🎯 **Advanced Challenge: Custom Policy**
Write a policy that ensures all deployments have specific labels (team, environment, version) and reject any that don't comply.
:::

### ✅ Policy Guardian Checkpoints

- [ ] **OPA Basics**: Understand Rego policy language (20 XP)
- [ ] **Gatekeeper Setup**: Deploy and configure Gatekeeper (20 XP)
- [ ] **Template Creation**: Write constraint templates (30 XP)
- [ ] **Policy Testing**: Test and validate policies (25 XP)
- [ ] **Violation Monitoring**: Monitor and respond to violations (30 XP)

:::success 🎉 **Achievement Unlocked!**
**📋 Policy Guardian** - You've mastered policy-as-code!  
**+125 XP** | **Special Reward**: Policy Template Library
:::

---

## 🔒 Bonus Achievement: mTLS Expert

Master mutual TLS for service-to-service communication.

### 🚀 mTLS Configuration Lab

```bash
# Verify Cilium mTLS status
kubectl get ciliumnetworkpolicies

# Check service mesh encryption
cilium connectivity test --test-suite=encryption

# View certificate rotation
kubectl logs -n spire-system spire-agent-xxx | grep rotation
```

### 📊 mTLS Monitoring

```bash
# Check mTLS metrics in Prometheus
kubectl port-forward svc/prometheus 9090:9090
# Query: cilium_policy_l7_total
# Query: spire_server_ca_manager_jwt_key_*
```

:::success 🎉 **Bonus Achievement Unlocked!**
**🔒 mTLS Expert** - You've secured service communication!  
**+50 XP** | **Special Reward**: mTLS Troubleshooting Guide
:::

---

## 🏆 Quest Complete: Security Champion!

**Congratulations, Security Champion!** You've mastered enterprise-grade security!

### 🎉 Final Rewards Summary

- **Total XP Earned**: 400+ XP
- **New Level**: Security Expert (Level 4)
- **Master Achievement**: 🛡️ **Security Champion**
- **Special Items**: Security playbooks, policy templates, monitoring dashboards

### 📜 Security Champion Certificate

```
🏆 CERTIFICATE OF ACHIEVEMENT 🏆

This certifies that you have successfully completed the
SECURITY CHAMPION QUEST

and have demonstrated mastery in:
✅ SPIFFE/SPIRE Identity Management
✅ HashiCorp Vault Secret Management  
✅ Open Policy Agent Governance
✅ Mutual TLS Communication
✅ Security Monitoring & Incident Response

Awarded on: [Date]
Quest Completion ID: SC-{timestamp}

You are now qualified to lead security initiatives
and mentor other security adventurers!
```

### 🚀 Next Adventures

Ready for more challenges? Continue your journey:

1. **[🤖 AI Explorer Quest](/docs/quests/ai-explorer)** - Secure AI/ML pipelines
2. **[⚙️ DevOps Master Quest](/docs/quests/devops-master)** - Advanced Kubernetes security
3. **🔥 Advanced Security Labs** - Penetration testing, compliance automation

### 🛡️ Security Resources

- **🔗 Security Runbooks**: `/docs/runbooks/security`
- **📋 Compliance Checklist**: `/docs/security/compliance`
- **🚨 Incident Response**: `/docs/runbooks/incident-response`
- **📊 Security Metrics**: Grafana Security Dashboard

:::tip 🎖️ **Security Champion Badge**
Add this badge to your professional profile:
```
🛡️ Enterprise Platform Security Champion
Certified in Identity, Secrets, and Policy Management
```
:::

---

## 💬 Security Community

Join fellow Security Champions:

- 🛡️ **Security Discord**: [#security-champions](https://discord.gg/security)
- 📚 **Security Wiki**: [Community Knowledge Base](https://wiki.enterprise-platform.com/security)
- 🎥 **Security Talks**: Monthly security deep-dives
- 🚨 **Incident Sharing**: Learn from real-world incidents

Remember: **Security is everyone's responsibility!** 🛡️✨