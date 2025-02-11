variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "AWS-Region"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-cluster"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_count" {
  description = "Number of worker nodes in the cluster"
  type        = number
  default     = 2
}

variable "eks_iam_role_name" {
  description = "IAM Role Name for EKS Cluster"
  type        = string
  default     = "eks-cluster-role"
}