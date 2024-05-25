provider "google" {
  credentials = var.google_credentials
  project     = var.project
  region      = var.region
}

variable "google_credentials" {
  type = string
}

variable "project" {
  default = "user-ilnggwfapqsi"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}
