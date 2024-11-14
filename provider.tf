terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.11.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }
  }

  backend "gcs" {
    bucket = "gcp-test-tfstate-5jc9pgw3um"
    prefix = "gcp-test/terraform-state"
  }

  required_version = "1.9.3"
}

data "google_client_config" "default" {}

data "google_compute_zones" "available" {}

data "google_container_cluster" "gke_test_cluster" {
  name     = local.gke_cluster_name
  location = local.location

  depends_on = [
    google_container_cluster.gke_test_cluster
  ]
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.gke_test_cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.gke_test_cluster.master_auth[0].cluster_ca_certificate)
  }
}
