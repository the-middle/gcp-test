locals {
  enabled_apis = [
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "container.googleapis.com",
    "gkehub.googleapis.com"
  ]
}
resource "google_project_service" "enabled_apis" {
  for_each           = toset(local.enabled_apis)
  service            = each.value
  disable_on_destroy = false
  project            = var.project_id
}
resource "null_resource" "prep" {
  depends_on = [google_project_service.enabled_apis]
}
