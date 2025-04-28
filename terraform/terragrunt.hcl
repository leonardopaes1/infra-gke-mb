locals {
  region = "us-central1"
  tfstate_bucket= get_env("TFSTATE_BUCKET")
  project_id   = get_env("GCP_PROJECT_ID")
}

remote_state {
  backend = "gcs"
  config = {
    bucket = local.tfstate_bucket
    prefix = local.project_id
    project = local.project_id
    location = "us-central1"
  }
}