provider "google" {
  credentials = jsondecode(file(var.google_credentials))
  project     = var.project
  region      = var.region
}

variable "google_credentials" {
  type = file
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
