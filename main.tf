resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    # El campo self_link proporciona la URL completa de la red, que es necesaria para conectar la instancia a la red.
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
    echo 'print("Hello, World!")' > app.py
    nohup python3 app.py &
  EOT
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_tcp_5000" {
  name    = "allow-tcp-5000"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }

  source_ranges = ["0.0.0.0/0"]
}

output "instance_ip" {
  value = length(google_compute_instance.vm_instance.network_interface[0].access_config) > 0 ? google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip : null
}
