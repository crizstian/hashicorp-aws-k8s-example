variable "region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "vpc_networks" {}
variable "kubernetes_cluster" {}
variable "tags" {}

locals {
  k8s = { for k, v in var.kubernetes_cluster : k => merge(v, {
    eks_managed_node_groups = merge(
      v.eks_managed_node_groups, {
        one = merge(
          v.eks_managed_node_groups.one,
          {
            vpc_security_group_ids = [
              aws_security_group.node_group_one.id
            ]
        })
        two = merge(
          v.eks_managed_node_groups.two,
          {
            vpc_security_group_ids = [
              aws_security_group.node_group_two.id
            ]
        })
    })
  }) }
}
