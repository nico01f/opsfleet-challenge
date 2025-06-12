variable "aws_region" {
  default = "us-east-1"
}

variable "tf_state_bucket" {
  default = "tf-state-backend-atlas-eks-ctoxbi"
}

variable "tf_lock_table" {
  default = "tf-state-lock-atlas-eks"
}
