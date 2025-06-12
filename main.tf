# main.tf (raíz)
module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_vpc_endpoints = var.enable_vpc_endpoints
  aws_region           = var.aws_region
}

module "iam" {
  source        = "./modules/iam"
  cluster_name  = var.cluster_name
}

module "iam_karpenter" {
  source = "./modules/iam_karpenter"
  cluster_name = var.cluster_name
  oidc_url     = module.eks.oidc_issuer_url
}

module "sg" {
  source        = "./modules/sg"
  vpc_id        = module.vpc.vpc_id
  cluster_name  = var.cluster_name
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = var.cluster_name
  cluster_version     = var.k8s_version
  vpc_id              = module.vpc.vpc_id
  private_subnets     = module.vpc.private_subnets
  security_group_ids  = [module.sg.eks_cluster_sg_id]
  eks_role_arn        = module.iam.eks_cluster_role_arn
}

module "temp_node_group" {
  source               = "./modules/eks/node_group_karpenter"
  cluster_name         = module.eks.cluster_name
  node_group_name      = "temp-karpenter-asg"
  node_role_arn        = module.iam_karpenter.karpenter_node_role_arn
  instance_profile_name = module.iam_karpenter.karpenter_instance_profile_name
  subnet_ids           = module.vpc.private_subnets
  cluster_dependency   = module.eks
}
