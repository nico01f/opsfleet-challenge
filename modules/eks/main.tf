# modules/eks/main.tf
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.private_subnets
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids      = var.security_group_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
  }

  tags = {
    Name = var.cluster_name
  }
}
