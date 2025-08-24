terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

locals {
  environment = "dev"
  region     = var.region
  
  common_tags = {
    Environment = local.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Network Module
module "network" {
  source = "../../modules/network"
  
  environment    = local.environment
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  
  tags = local.common_tags
}

# Kubernetes Module
module "kubernetes" {
  source = "../../modules/kubernetes"
  
  environment         = local.environment
  cluster_name        = "${var.project_name}-${local.environment}"
  kubernetes_version  = var.kubernetes_version
  
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  
  node_groups = var.node_groups
  
  tags = local.common_tags
  
  depends_on = [module.network]
}

# Storage Module
module "storage" {
  source = "../../modules/storage"
  
  environment = local.environment
  
  postgres_config = var.postgres_config
  redis_config    = var.redis_config
  
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  
  tags = local.common_tags
  
  depends_on = [module.network]
}

# Vault Module
module "vault" {
  source = "../../modules/vault"
  
  environment = local.environment
  
  vault_config = var.vault_config
  
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  
  tags = local.common_tags
  
  depends_on = [module.kubernetes]
}