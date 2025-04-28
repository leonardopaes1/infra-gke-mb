
include {
  path = find_in_parent_folders()
}

locals {
  project_id   = get_env("GCP_PROJECT_ID")
  cluster_name = get_env("CLUSTER_NAME")
  owner_email  = get_env("EMAIL_ALERT")
}

terraform {
  source = "../../modules/gke"
}

inputs = {
  project_id   = local.project_id
  cluster_name = local.cluster_name
  region       = "us-central1"
  network      = "default"
  subnetwork   = "default"
  zone       = "us-central1-c" #Remover caso queira voltar o cluster para regional
  location = "us-central1-c"
  alert_email_address = local.owner_email

  node_pools = {
    # Node Pools Settings
    prod-pool = {
      machine_type = "e2-medium"
      node_count   = 1
      labels       = { env = "prod" }
      taint_key    = "env"
      taint_value  = "prod"
      taint_effect = "NO_SCHEDULE"
    }
    staging-pool = {
      machine_type = "e2-medium"
      node_count   = 1
      labels       = { env = "staging" }
      taint_key    = "env"
      taint_value  = "staging"
      taint_effect = "NO_SCHEDULE"
    }
    
  }
  
}
