variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS managed node group"
}

variable "node_role_arn" {
  type        = string
  description = "IAM Role ARN for the node group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the node group"
}

variable "cluster_dependency" {
  description = "Module or resource to depend on for EKS cluster creation"
  type        = any
}

variable "instance_profile_name" {
  description = "IAM instance profile name to associate with the launch template"
  type        = string
}
