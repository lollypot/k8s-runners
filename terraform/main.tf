resource "google_container_cluster" "main" {
  provider                  = google-beta
  name                      = "${var.prefix}-${var.environment}"
  location                  = var.gcp_zone
  project                   = data.google_project.main.project_id
  initial_node_count        = 1
  remove_default_node_pool  = true

  cluster_autoscaling {
    enabled = true
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    resource_limits {
      resource_type = "cpu"
      minimum       = 0
      maximum       = "10"
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 0
      maximum       = "32"
    }
  }

  # List available versions:
  #   gcloud container get-server-config --zone us-central1-a
  min_master_version  = var.gke_master_version

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    enabled = true
    provider = "CALICO"
  }
}
