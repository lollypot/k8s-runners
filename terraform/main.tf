resource "google_container_cluster" "main" {
  name                      = "${var.prefix}-${var.environment}"
  location                  = var.gcp_zone
  project                   = data.google_project.main.project_id
  initial_node_count        = 1
  remove_default_node_pool  = true # using node pool definitions

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

  node_config {
    metadata = {
      "disable-legacy-endpoints" = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",

      # # Required by toggbook services - consider changing to service account capability
      # "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Create GKE Image Puller service account
#
resource "google_service_account" "gke_image_puller" {
  account_id          = "sa-${substr(md5(format("%s-%s",var.prefix,var.environment)),0,20)}"
  display_name        = "${var.prefix}-${var.environment} GKE Image Puller service account"
  project             = data.google_project.main.project_id
}
resource "google_service_account_key" "gke_image_puller_key" {
  service_account_id  = google_service_account.gke_image_puller.name
}
resource "local_file" "gke_image_puller_key_file" {
  sensitive_content = base64decode(google_service_account_key.gke_image_puller_key.private_key)
  filename          = "${path.module}/.keys/gke_image_puller_key-${data.google_project.main.project_id}.json"
  file_permission   = "0600"
  directory_permission = "0755"
}
resource "local_file" "gke_image_puller_key_file_b64" {
  sensitive_content = google_service_account_key.gke_image_puller_key.private_key
  filename          = "${path.module}/.keys/gke_image_puller_key-${data.google_project.main.project_id}.json.b64"
  file_permission   = "0600"
  directory_permission = "0755"
}
resource "google_storage_bucket_iam_member" "main" {
  bucket = "artifacts.${var.gcp_project_id}.appspot.com"
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.gke_image_puller.email}"
}

resource "google_container_node_pool" "main" {
  name       = "node-pool-main"
  location   = var.gcp_zone
  project    = data.google_project.main.project_id
  cluster    = google_container_cluster.main.name
  initial_node_count = 1
  version    = var.gke_node_version
  autoscaling {
    min_node_count = 1
    max_node_count = 50
  }
  management {
    auto_repair = true
  }

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"
    metadata = {
      "disable-legacy-endpoints" = "true"
    }
    oauth_scopes = [
      # These 4 scopes are required for correct cluster functioning
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",

      # Required by toggbook services - consider changing to service account capability
      "cloud-platform"
    ]
  }
}
