data "google_project" "main" {
  project_id = var.gcp_project_id
}

data "google_container_registry_repository" "main" {
  project   = data.google_project.main.project_id
}
