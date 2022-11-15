terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.12.1"
    }
  }

  required_version = "~> 1.3"

  backend "s3" {}
}

# provider "kubernetes" {
#   host                   = module.eks["${terraform.workspace}_k8s"].cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks["${terraform.workspace}_k8s"].cluster_certificate_authority_data)
# }

provider "aws" {
  region = var.region
}


