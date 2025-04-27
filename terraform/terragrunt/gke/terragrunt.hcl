
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/gke"
}

inputs = {
  project_id   = "sre-teste-458021"
  cluster_name = "sre-cluster"
  region       = "us-central1"
  network      = "default"
  subnetwork   = "default"
  zone       = "us-central1-c" #Remover caso queira voltar o cluster para regional
  location = "us-central1-c"

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
  alert_email_address = "leonardpaes@gmail.com"
}
