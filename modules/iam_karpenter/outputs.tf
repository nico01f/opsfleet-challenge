output "karpenter_node_role_arn" {
  value = aws_iam_role.karpenter_node.arn
}

output "karpenter_instance_profile_name" {
  value = aws_iam_instance_profile.karpenter_node.name
}
