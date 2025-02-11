provider "aws" {
  region = var.region
}

# ---------------
# VPC and Subnets
# ---------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[0]
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[1]
  availability_zone = "${var.region}b"
}

# ------------------------
# IAM Role for EKS Cluster
# ------------------------
resource "aws_iam_role" "eks" {
  name = var.eks_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# -----------
# EKS Cluster
# -----------
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]
}

# ----------------------------
# EKS Node Group (Worker Nodes)
# ----------------------------
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks.arn
  subnet_ids      = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  instance_types  = [var.instance_type]
  scaling_config {
    desired_size = var.node_count
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_eks_cluster.eks
  ]
}