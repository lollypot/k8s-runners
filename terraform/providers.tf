terraform {
  required_providers {
    google      = "~> 3.22"
    local       = "~> 1.3"
  }
}

provider "google" {
  region      = var.gcp_region
  zone        = var.gcp_zone
}
