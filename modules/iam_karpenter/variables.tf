variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "oidc_url" {
  type        = string
  description = "OIDC issuer URL from EKS cluster"
}
