locals {
  gcp_project_id = run_cmd("bash","-c","gcloud projects list --format=json | jq '.[]' | jq 'select(.name==\"My First Project\")' | jq -r '.projectId'")
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = "${local.gcp_project_id}-tfstate"
    prefix = "terraform/state"
  }
}

terraform {
  source = "${get_parent_terragrunt_dir()}///"
}

inputs = {
  prefix = "stress"
  environment = "runners"
  gcp_project_id = local.gcp_project_id
  gke_master_version = "1.22.6-gke.300"
  gke_node_version = "1.22.6-gke.300"
  gcp_zone = "europe-west3"
  maximum_cpu = "10"
  maximum_memory = "32"
}
