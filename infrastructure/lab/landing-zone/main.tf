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

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 1.3"

 

  name       = "${var.project}-bucket"
  project_id = var.project
  location   = var.location
}

 

# Network - default
resource "google_compute_network" "vpc_default_network" {
  name                    = var.network_default
  auto_create_subnetworks = var.default_network_auto_create_subnetworks
  project                 = var.project
}

 

# Network - custom

 

resource "google_compute_network" "vpc_custom_network" {
  name                    = var.network_custom
  auto_create_subnetworks = var.custom_network_auto_create_subnetworks
  project                 = var.project
  routing_mode            = var.custom_network_routing_mode
}

 

# Subnet - custom
resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.custom_subnetwork
  ip_cidr_range = var.primarycidr
  region        = var.region
  project       = var.project
  network       = google_compute_network.vpc_custom_network.id
  secondary_ip_range {
    range_name    = var.secondary_range_name
    ip_cidr_range = var.secondarycidr
  }
}

 

# Router - default
resource "google_compute_router" "router" {
  name    = var.router_name
  region  = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
  network = google_compute_network.vpc_default_network.id

 

  bgp {
    asn = var.router_bgp_asn
  }
}

 

# NAT - default
resource "google_compute_router_nat" "nat" {
  name                               = var.nat_router_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = var.nat_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.subnetwork_ip_ranges_to_nat

 

  log_config {
    enable = var.log_config_enable
    filter = var.log_config_filter
  }
}

 

# Firewall Rules - Custom
module "firewall_rules" {
  depends_on = [
    google_compute_network.vpc_custom_network,
  ]
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project
  network_name =  google_compute_network.vpc_custom_network.name

 

  rules = [{
    name                    = var.custom_firewall_rules_name
    description             = var.custom_firewall_rules_description
    direction               = var.custom_firewall_rules_direction
    priority                = var.custom_firewall_rules_priority
    ranges                  = var.custom_firewall_rules_ranges
    source_tags             = var.custom_firewall_rules_source_tags
    source_service_accounts = var.custom_firewall_rules_source_service_accounts
    target_tags             = var.custom_firewall_rules_source_target_tags
    target_service_accounts = var.custom_firewall_rules_target_service_accounts
    allow = [{
      protocol = var.custom_firewall_rules_allow_protocol
      ports    = var.custom_firewall_rules_allow_ports
    }]
    deny = []
    log_config = {
      metadata = var.custom_firewall_rules_log_config_metadata
    }
  }]
}

 

# Firewall Rule - default
module "firewall_rules2" {
  depends_on = [
    google_compute_network.vpc_default_network,
  ]
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project
  network_name =  var.default_firewall_network_name

 

  rules = [{
    name                    = var.default_firewall_rules_name
    description             = var.default_firewall_rules_description
    direction               = var.default_firewall_rules_direction
    priority                = var.default_firewall_rules_priority
    ranges                  = var.default_firewall_rules_ranges
    source_tags             = var.default_firewall_rules_source_tags
    source_service_accounts = var.default_firewall_rules_source_service_accounts
    target_tags             = var.default_firewall_rules_source_target_tags
    target_service_accounts = var.default_firewall_rules_target_service_accounts
    allow = [{
      protocol = var.default_firewall_rules_allow_protocol
      ports    = var.default_firewall_rules_allow_ports
    }]
    deny = []
    log_config = {
      metadata = var.default_firewall_rules_log_config_metadata
    }
  }]
}

 


resource "google_sourcerepo_repository" "hpc_repo" {
  name = var.repo_name
  project = var.project
}