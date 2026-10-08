terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.2"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

locals {
  eks_cluster_name = keys(var.eks_clusters)[0]
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoints[local.eks_cluster_name]
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authorities[local.eks_cluster_name])

  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"

    args = [
      "eks",
      "get-token",
      "--cluster-name",
      local.eks_cluster_name,
      "--region",
      var.aws_region
    ]
  }
}

provider "helm" {
  kubernetes = {
    host                   = module.eks_cluster.cluster_endpoints[local.eks_cluster_name]

    cluster_ca_certificate = base64decode(
      module.eks_cluster.cluster_certificate_authorities[local.eks_cluster_name]
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1"

      command = "aws"

      args = [
        "eks",
        "get-token",
        "--cluster-name",
        local.eks_cluster_name,
        "--region",
        var.aws_region
      ]
    }
  }
}

data "aws_caller_identity" "current" {}
