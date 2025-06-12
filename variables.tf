variable "aws_region" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "azs" {
  type = list(string)
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "enable_vpc_endpoints" {
  type    = bool
  default = true
}
variable "k8s_version" {
  default = "1.31"
}
variable "cluster_name" {
  type = string
  default = "cluster-eks"
}
