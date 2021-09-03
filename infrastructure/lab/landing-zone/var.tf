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

variable "project" {
  type    = string  
}

 

variable "location" {
    type    = string 
}

 

variable "primarycidr" {
  type  = string
}

 

variable "secondarycidr" {
  type  = string
}

 

variable "network_default" {
  default = "default"
}

 

variable "default_network_auto_create_subnetworks" {
    default = true
}

 

variable "network_custom" {
  default = "custom"
}

 


variable "custom_network_auto_create_subnetworks" {
    default = false
}

 

variable "custom_network_routing_mode" {
    default = "GLOBAL"
}

 

variable "custom_subnetwork" {
  default = "custom-subnetwork"
}

 

variable "region" {
    default = "us-central1" 
}

 

variable "secondary_range_name" {
    default = "tf-test-secondary-range-update1" 
}

 

variable "router_name" {
    default = "hpc-router" 
}

 

variable "router_bgp_asn" {
    default =  64514
}

 

variable "nat_router_name" {
    default = "hpc-router-nat" 
}

 

variable "nat_allocate_option" {
    default = "AUTO_ONLY"
}

 

variable "subnetwork_ip_ranges_to_nat" {
    default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

 

variable "log_config_enable" {
    default =  true
}

 

variable "log_config_filter" {
    default = "ERRORS_ONLY" 
}

 

variable "custom_firewall_rules_name" {
    default = "allow-iap-ingress-custom"
}

 

variable "custom_firewall_rules_description" {
    default = null
}

 

variable "custom_firewall_rules_direction" {
    default = "INGRESS"
}

 

variable "custom_firewall_rules_priority" {
    default = null
}

 

variable "custom_firewall_rules_ranges" {
    default = ["35.235.240.0/20"]
}

 

variable "custom_firewall_rules_source_tags" {
    default = null
}

 

variable "custom_firewall_rules_source_service_accounts" {
    default = null
}

 

variable "custom_firewall_rules_source_target_tags" {
    default = null
}

 

variable "custom_firewall_rules_target_service_accounts" {
    default = null
}

 

variable "custom_firewall_rules_allow_protocol" {
    default = "TCP"
}

 

variable "custom_firewall_rules_allow_ports" {
    default = [22, 3389]
}

 

variable "custom_firewall_rules_log_config_metadata" {
    default = "INCLUDE_ALL_METADATA"
}

 

/*
*/

 

variable "default_firewall_network_name" {
    default = "default"
}

 

variable "default_firewall_rules_name" {
    default = "allow-iap-ingress-default"
}

 

variable "default_firewall_rules_description" {
    default = null
}

 

variable "default_firewall_rules_direction" {
    default = "INGRESS"
}

 

variable "default_firewall_rules_priority" {
    default = null
}

 

variable "default_firewall_rules_ranges" {
    default = ["35.235.240.0/20"]
}

 

variable "default_firewall_rules_source_tags" {
    default = null
}

 

variable "default_firewall_rules_source_service_accounts" {
    default = null
}

 

variable "default_firewall_rules_source_target_tags" {
    default = null
}

 

variable "default_firewall_rules_target_service_accounts" {
    default = null
}

 

variable "default_firewall_rules_allow_protocol" {
    default = "TCP"
}

 

variable "default_firewall_rules_allow_ports" {
    default = [22, 3389]
}

 

variable "default_firewall_rules_log_config_metadata" {
    default = "INCLUDE_ALL_METADATA"
}

 

variable "repo_name" {
    default = "hpc-lab-samples"
}