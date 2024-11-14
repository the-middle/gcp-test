resource "helm_release" "kube_prometheus_stack" {
  name  = "kube-prometheus-stack"
  chart = "./helm_charts/kube-prometheus-stack"

  create_namespace = true
  namespace        = "monitoring"

  values = [
    file("./helm_charts/kube-prometheus-stack/values.edited.yaml")
  ]

  depends_on = [
    google_container_node_pool.gke_test_node_pool
  ]
}

resource "helm_release" "ethereum_node" {
  name  = "ethereum-node"
  chart = "./helm_charts/ethereum-node"

  create_namespace = true
  namespace        = "eth"

  values = [
    file("./helm_charts/ethereum-node/values.edited.yaml")
  ]

  depends_on = [
    helm_release.kube_prometheus_stack
  ]
}
