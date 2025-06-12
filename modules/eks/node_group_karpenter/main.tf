data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/1.29/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "karpenter" {
  name_prefix = "${var.cluster_name}-karpenter"
  image_id    = data.aws_ssm_parameter.eks_ami.value

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-karpenter"
    }
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.cluster_name}
  EOT
  )
}

resource "aws_eks_node_group" "default" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"

  launch_template {
    id      = aws_launch_template.karpenter.id
    version = aws_launch_template.karpenter.latest_version
  }

  tags = {
    Name = "${var.cluster_name}-node-group"
  }

  depends_on = [var.cluster_dependency]
}
