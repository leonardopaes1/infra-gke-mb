# main.tf

terraform {
  backend "gcs" {}
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.32.0"
    }
  }
}

provider "google" {
  #access_token = var.access_token
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  # location = var.region #Removemos a configuracao regional para diminuir o custo desse desafio
  location = var.zone

  remove_default_node_pool = true
  initial_node_count = 1
  project = var.project_id
  deletion_protection      = false

  network    = var.network
  subnetwork = var.subnetwork

  ip_allocation_policy {
    stack_type = "IPV4"
  }

  lifecycle {
    ignore_changes = [node_pool, dns_config]
  }

}

resource "google_container_node_pool" "node_pools" {
  for_each = var.node_pools

  name     = each.key
  cluster  = google_container_cluster.primary.name
  location = var.zone #Mudar para region se precisar volta a configuracao
  project  = var.project_id

  node_count = each.value.node_count

  node_config {
    machine_type = each.value.machine_type
    labels       = each.value.labels

    taint {
      key    = each.value.taint_key
      value  = each.value.taint_value
      effect = each.value.taint_effect
    }
  

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

resource "google_compute_router" "router" {
  name    = "${var.cluster_name}-router"
  network = var.network
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.cluster_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}