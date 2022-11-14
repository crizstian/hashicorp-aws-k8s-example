data "aws_availability_zones" "available" {}

module "vpc" {
  source   = "terraform-aws-modules/vpc/aws"
  version  = "3.14.2"
  for_each = var.vpc_networks

  name = "${each.key}-vpc"
  azs  = data.aws_availability_zones.available.names
  tags = var.tags

  cidr                 = each.value.vpc_cidr
  private_subnets      = each.value.private_subnets
  public_subnets       = each.value.public_subnets
  enable_nat_gateway   = each.value.enable_nat_gateway
  single_nat_gateway   = each.value.enable_nat_gateway
  enable_dns_hostnames = each.value.enable_nat_gateway
  public_subnet_tags   = each.value.public_subnet_tags
  private_subnet_tags  = each.value.private_subnet_tags

}

module "eks" {
  source   = "terraform-aws-modules/eks/aws"
  version  = "18.26.6"
  for_each = var.k8s_cluster

  cluster_name = "${each.key}-eks"
  tags         = var.tags
  vpc_id       = module.vpc[each.value.vpc].vpc_id
  subnet_ids   = module.vpc[each.value.vpc].private_subnets

  cluster_version                 = each.value.cluster_version
  eks_managed_node_group_defaults = each.value.eks_managed_node_group_defaults
  eks_managed_node_groups         = each.value.eks_managed_node_groups
}
