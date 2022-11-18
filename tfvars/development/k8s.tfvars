kubernetes_clusters = {
  development_k8s = {
    cluster_version = "1.22"
    vpc             = "development_vpc"

    eks_managed_node_group_defaults = {
      ami_type                              = "AL2_x86_64"
      attach_cluster_primary_security_group = true
      create_security_group                 = false
    }

    eks_managed_node_groups = {
      one = {
        name           = "node-one-1"
        instance_types = ["t3.medium"]
        min_size       = 2
        max_size       = 2
        desired_size   = 2

        pre_bootstrap_user_data = <<-EOT
            echo 'foo bar'
        EOT
      }
    }
  }
}
