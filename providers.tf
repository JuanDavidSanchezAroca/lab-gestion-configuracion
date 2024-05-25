provider "google" {
  credentials = var.google_credentials.google_credentials
  project     = var.project
  region      = var.region
}

variable "google_credentials" {
  type = string
}

variable "project" {
  type    = string
  default = "user-ilnggwfapqsi"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}
