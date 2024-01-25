terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("<NAME>.json")
  project = "rare-sound-412302"
  region  = "us-central1"
  
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
