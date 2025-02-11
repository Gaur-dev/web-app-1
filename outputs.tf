output "cluster_id" {
  description = "ID of the created Kubernetes cluster"
  value       = aws_eks_cluster.eks.id
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate" {
  description = "certificate for cluster authentication"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
  sensitive   = true
}

output "node_group_arn" {
  description = "ARN of the worker node group"
  value       = aws_eks_node_group.node_group.arn
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = aws_subnet.subnet[*].id
}

output "eks_iam_role_arn" {
  description = "IAM Role ARN assigned to EKS Cluster"
  value       = aws_iam_role.eks.arn
}