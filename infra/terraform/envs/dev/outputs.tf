output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.kubernetes.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Kubernetes cluster security group ID"
  value       = module.kubernetes.cluster_security_group_id
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.network.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "postgres_endpoint" {
  description = "PostgreSQL endpoint"
  value       = module.storage.postgres_endpoint
  sensitive   = true
}

output "redis_endpoint" {
  description = "Redis endpoint"
  value       = module.storage.redis_endpoint
}

output "vault_endpoints" {
  description = "Vault cluster endpoints"
  value       = module.vault.vault_endpoints
}