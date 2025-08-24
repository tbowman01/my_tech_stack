variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "enterprise-ai-platform"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

variable "node_groups" {
  description = "EKS node group configurations"
  type = map(object({
    instance_types = list(string)
    min_size      = number
    max_size      = number
    desired_size  = number
    disk_size     = number
    labels        = map(string)
    taints        = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = {
    general = {
      instance_types = ["t3.medium"]
      min_size      = 1
      max_size      = 5
      desired_size  = 3
      disk_size     = 50
      labels        = {
        role = "general"
      }
      taints = []
    }
    ai-workloads = {
      instance_types = ["g4dn.xlarge"]
      min_size      = 0
      max_size      = 3
      desired_size  = 1
      disk_size     = 100
      labels        = {
        role = "ai-workloads"
        "nvidia.com/gpu" = "true"
      }
      taints = [{
        key    = "nvidia.com/gpu"
        value  = "true"
        effect = "NO_SCHEDULE"
      }]
    }
  }
}

variable "postgres_config" {
  description = "PostgreSQL configuration"
  type = object({
    instance_class = string
    allocated_storage = number
    engine_version = string
    multi_az = bool
    backup_retention_period = number
  })
  default = {
    instance_class = "db.t3.micro"
    allocated_storage = 20
    engine_version = "15.4"
    multi_az = false
    backup_retention_period = 7
  }
}

variable "redis_config" {
  description = "Redis configuration"
  type = object({
    node_type = string
    num_cache_nodes = number
    engine_version = string
  })
  default = {
    node_type = "cache.t3.micro"
    num_cache_nodes = 1
    engine_version = "7.0"
  }
}

variable "vault_config" {
  description = "Vault configuration"
  type = object({
    instance_type = string
    replica_count = number
  })
  default = {
    instance_type = "t3.small"
    replica_count = 3
  }
}