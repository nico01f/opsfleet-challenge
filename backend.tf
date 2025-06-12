terraform {
  backend "s3" {
    bucket         = "tf-state-backend-atlas-eks-ctoxbi"
    key            = "dev/atlas-eks.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-lock-atlas-eks"
    encrypt        = true
  }

  required_version = ">= 1.5.7"
}
