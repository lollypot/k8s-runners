variable "prefix" {
  description = "A prefix used for all resources"
  type = string
}

variable "environment" {
  description = "A environment used for all resources"
  type = string
}

variable "gcp_project_id" {
  type    = string
}

variable "gcp_region" {
  type    = string
  default = "us-central1"
}

variable "gcp_zone" {
  type    = string
  default = "us-central1-a"
}

variable "gke_master_version" {
  type    = string
}

variable "gke_node_version" {
  type    = string
}
