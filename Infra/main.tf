terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.35.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "playground-s-11-db40a311" #change it to your project id
  region = "us-central1" #"me-west"
  zone = "us-central1-a"
  credentials = file("gcp-creds/terraform-key.json")
}

resource "google_project_iam_member" "compute_admin" {
  project = "playground-s-11-db40a311"
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:terraform-admin@playground-s-11-db40a311.iam.gserviceaccount.com"
}

resource "google_compute_instance" "basic-compute" {
  name         = "test-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}