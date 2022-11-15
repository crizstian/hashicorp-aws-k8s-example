output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks["${terraform.workspace}_k8s"].cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks["${terraform.workspace}_k8s"].cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks["${terraform.workspace}_k8s"].cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = "${terraform.workspace}_k8s"
}
