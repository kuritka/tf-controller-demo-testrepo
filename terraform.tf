terraform {
  required_version = ">= 1.3.0, < 2.0.0"

  backend "kubernetes" {
    secret_suffix  = "state"
    config_path    = "/var/.kube/kubeconfig.yaml"
    namespace      = "backend"
    config_context = "k3d-west"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.3"
    }
  }
}

provider "kubernetes" {
  config_path    = "/var/.kube/kubeconfig.yaml"
  config_context = var.context
  #  terraform plan runs in terraform cloud and doesn't have access to the kubeconfig file
  #  terraform cloud can set terraform variables which can be used to set the kubernetes provider
  #  we can't use the environment varibles, because they are can't set PEM format for the certificate-authority-data etc.
  # https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#argument-reference
}
