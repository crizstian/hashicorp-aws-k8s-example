region = "ca-central-1"

vpc_networks = {
  cristian_labs_infrateam_k8s = {
    enable             = true
    vpc_cidr           = "10.0.0.0/16"
    private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
    enable_nat_gateway = true

    public_subnet_tags = {
      "kubernetes.io/cluster/${local.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                      = 1
    }

    private_subnet_tags = {
      "kubernetes.io/cluster/${local.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"             = 1
    }
  }
}

kubernetes_cluster = {
  infrateam_k8s = {
    cluster_version = "1.22"
    vpc             = "cristian_labs_infrateam_k8s"

    eks_managed_node_group_defaults = {
      ami_type                              = "AL2_x86_64"
      attach_cluster_primary_security_group = true
      create_security_group                 = false
    }

    eks_managed_node_groups = {
      one = {
        name                    = "node-group-1"
        instance_types          = ["t3.small"]
        min_size                = 1
        max_size                = 1
        desired_size            = 1
        pre_bootstrap_user_data = <<-EOT
            echo 'foo bar'
        EOT
      }

      two = {
        name           = "node-group-2"
        instance_types = ["t3.medium"]
        min_size       = 1
        max_size       = 1
        desired_size   = 1

        pre_bootstrap_user_data = <<-EOT
            echo 'foo bar'
        EOT
      }
    }
  }
}

tags = {
  Terraform   = "true"
  Environment = "SE Latam"
  Owner       = "Cristian Ramirez"
}
