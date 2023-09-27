
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
