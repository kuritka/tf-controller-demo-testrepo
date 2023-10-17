
locals {
  common_annotations = {
    "tf-controller-repo" = "kuritka/tf-controller"
    "tf-controller-demo" = "k8s"
  }
}



resource "kubernetes_namespace" "tf_controller_test" {
  metadata {
    annotations = local.common_annotations
    labels      = {}
    name        = var.name
  }
}


resource "kubernetes_secret" "example" {
  metadata {
    name      = "basic-auth"
    namespace = kubernetes_namespace.tf_controller_test.metadata[0].name
  }

  data = {
    username = "test"
    password = "test"
  }

  type = "kubernetes.io/basic-auth"
}

