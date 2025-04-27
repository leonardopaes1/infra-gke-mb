# variables.tf
variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região onde o cluster será criado"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona onde o cluster GKE será criado"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster Kubernetes"
  type        = string
}

variable "network" {
  description = "Nome da VPC"
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Nome da sub-rede"
  type        = string
  default     = "default"
}

variable "node_pools" {
  type = map(object({
    machine_type = string
    node_count   = number
    labels       = map(string)
    taint_key    = string
    taint_value  = string
    taint_effect = string
  }))
}

variable "alert_email_address" {
  description = "E-mail address to send alert notifications"
  type        = string
}


variable "workload_identity_provider" {
  type        = string
  default     = "default"
}


variable "service_account_email" {
  type        = string
  default     = "default"
}