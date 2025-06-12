# modules/eks/variables.tf
variable "cluster_name" {
  type = string
  default = "cluster-eks"
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "eks_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  type        = string
}

variable "k8s_version" {
  default = "1.31"
}
