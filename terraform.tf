terraform {
  required_version = ">= 1.3.0, < 2.0.0"

  backend "kubernetes" {
    # creates default secret name terraform-<workspace-name>-state in backend namespace
    secret_suffix  = "state"
    config_path    = "~/.kube/config"
    namespace      = "backend"
    config_context = "k3d-backend"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.3"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "kubernetes" {
}

