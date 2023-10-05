
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

resource "kubectl_manifest" "fleet-gitrepo" {
  yaml_body = <<YAML
apiVersion: fleet.cattle.io/v1alpha1
kind: GitRepo
metadata:
  name: "some-name"
  namespace: ${kubernetes_namespace.tf_controller_test.metadata[0].name}
spec:
  repo: "github.com/kuritka/tf-controller-demo-testrepo"
  branch: "main"
  clientSecretName: ${kubernetes_secret.example.data.username}
  helmSecretName: fleet-proxy-ca
  insecureSkipTLSVerify: true
  paths:
    - "helm"
  targets:
    - clusterSelector:
        matchLabels:
          env: ${local.common_annotations.tf-controller-repo}
 YAML
}
