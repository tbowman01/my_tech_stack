package main

import rego.v1

# Deny privileged containers
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    container.securityContext.privileged == true
    msg := sprintf("Privileged containers are not allowed in deployment '%s'", [input.metadata.name])
}

# Deny containers without security context
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.securityContext
    msg := sprintf("Container '%s' in deployment '%s' must have securityContext defined", [container.name, input.metadata.name])
}

# Deny containers running as root
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    container.securityContext.runAsUser == 0
    msg := sprintf("Container '%s' in deployment '%s' cannot run as root user", [container.name, input.metadata.name])
}

# Deny containers without resource limits
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits
    msg := sprintf("Container '%s' in deployment '%s' must have resource limits", [container.name, input.metadata.name])
}

# Deny containers without CPU limits
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits.cpu
    msg := sprintf("Container '%s' in deployment '%s' must have CPU limit", [container.name, input.metadata.name])
}

# Deny containers without memory limits
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits.memory
    msg := sprintf("Container '%s' in deployment '%s' must have memory limit", [container.name, input.metadata.name])
}

# Deny containers with writable root filesystem
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.securityContext.readOnlyRootFilesystem
    msg := sprintf("Container '%s' in deployment '%s' must have readOnlyRootFilesystem: true", [container.name, input.metadata.name])
}

# Deny containers with privilege escalation
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    container.securityContext.allowPrivilegeEscalation == true
    msg := sprintf("Container '%s' in deployment '%s' cannot allow privilege escalation", [container.name, input.metadata.name])
}

# Warn for containers without resource requests
warn contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.requests
    msg := sprintf("Container '%s' in deployment '%s' should have resource requests", [container.name, input.metadata.name])
}

# Warn for missing liveness probe
warn contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.livenessProbe
    msg := sprintf("Container '%s' in deployment '%s' should have a liveness probe", [container.name, input.metadata.name])
}

# Warn for missing readiness probe
warn contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.readinessProbe
    msg := sprintf("Container '%s' in deployment '%s' should have a readiness probe", [container.name, input.metadata.name])
}