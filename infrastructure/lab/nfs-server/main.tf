/*
Copyright 2021 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

resource "google_compute_firewall" "nfs_firewall_rule" {
  name    = "${var.name_prefix}-nfs"
  network = var.network
  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/8"]
}

// Use an external disk so that it can be remounted on another instance.
resource "google_compute_disk" "default" {
  name  = "${var.name_prefix}-disk"
  image = var.image_family
  size  = var.disk_size
  type  = var.type
  zone  = var.zone
}

resource "google_compute_instance" "compute_instance" {
  project                 = var.project_id
  name                    = "${var.name_prefix}-instance"
  zone                    = var.zone
  machine_type            = var.machine_type
  metadata_startup_script = "${file("nfs_server_startup.sh")}"

  boot_disk {
    auto_delete = var.auto_delete_disk
    source      = google_compute_disk.default.name
  }

  network_interface {
    network = var.network
  }
}