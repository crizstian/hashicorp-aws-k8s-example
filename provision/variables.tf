variable "region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "vpc_networks" {
  type = map(object({
    enable             = bool
    vpc_cidr           = string
    private_subnets    = list(string)
    public_subnets     = list(string)
    enable_nat_gateway = bool
  }))
}
variable "kubernetes_clusters" {
  type = map(object({
    cluster_version                 = string
    vpc                             = string
    eks_managed_node_group_defaults = map(string)
    eks_managed_node_groups = map(object({
      name                    = string
      instance_types          = list(string)
      min_size                = number
      max_size                = number
      desired_size            = number
      pre_bootstrap_user_data = string
    }))
  }))
}

locals {
  k8s_vpcs = merge([for cluster, v in var.kubernetes_clusters : { for key, value in var.vpc_networks : key => merge(value, {
    public_subnet_tags = {
      "kubernetes.io/cluster/${cluster}" = "shared"
      "kubernetes.io/role/elb"           = 1
    }

    private_subnet_tags = {
      "kubernetes.io/cluster/${cluster}" = "shared"
      "kubernetes.io/role/internal-elb"  = 1
    }
  }) } if "${terraform.workspace}_k8s" == cluster]...)


  k8s = { for cluster, v in var.kubernetes_clusters : cluster => merge(v, {
    eks_managed_node_groups = merge(
      v.eks_managed_node_groups, {
        one = merge(
          v.eks_managed_node_groups.one,
          {
            vpc_security_group_ids = [
              aws_security_group.node_group_one[v.vpc].id
            ]
        })
    })
  }) if "${terraform.workspace}_k8s" == cluster }
}
