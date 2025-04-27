locals {
  region = "us-central1"
}

remote_state {
  backend = "gcs"
  config = {
    bucket = "leonardopaes-teste-tfstate"
    prefix = "desafio-mb-infrastructure"
    project = "sre-teste-458021"
    location = "us-central1"
  }
}