locals {
  gke_cluster_name = "gke-test-cluster"
  location         = "europe-central2-b"
}

data "google_compute_subnetwork" "default_europe_central2" {
  name   = "default"
  region = var.region
}

resource "google_service_account" "default" {
  account_id   = "default-service-account"
  display_name = "Service Account For GKE"

  depends_on = [null_resource.prep]
}

resource "google_container_cluster" "gke_test_cluster" {
  name     = local.gke_cluster_name
  location = local.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  monitoring_service = "none"
  logging_service    = "none"

  network    = "default"
  subnetwork = data.google_compute_subnetwork.default_europe_central2.self_link

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  default_max_pods_per_node = 110

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }

  depends_on = [
    google_service_account.default
  ]
}

resource "google_container_node_pool" "gke_test_node_pool" {
  name       = "gke-test-node-pool"
  location   = local.location
  cluster    = google_container_cluster.gke_test_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

