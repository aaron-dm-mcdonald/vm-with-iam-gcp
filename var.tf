locals {
  project_id = data.google_client_config.default.project
}

data "google_client_config" "default" {}


output "project_id" {
  value = local.project_id
}