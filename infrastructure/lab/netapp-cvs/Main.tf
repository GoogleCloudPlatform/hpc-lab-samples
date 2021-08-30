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

# Install provider from terraform register, only available for version 0.13 and above.
terraform {
  required_providers {
    netapp-gcp = {
      source = "NetApp/netapp-gcp"
      version = "20.10.0"
    }
  }
}

# Configure the NetApp_GCP Provider
provider "netapp-gcp" {
  project         = var.project
  service_account = var.service_account
}

# Create a volume tied to an account
resource "netapp-gcp_volume" "gcp-volume" {
  provider = netapp-gcp
  name = "deleteme_asapGO_jusitin"
  region = "us-west2"
  protocol_types = ["NFSv3"]
  network = "cvs-terraform-vpc"
  size = 1024
  service_level = "premium"
  volume_path = "deleteme-asapGO"
  snapshot_policy {
    enabled = true
    daily_schedule {
      hour = 10
      minute = 1
    }
  }
  export_policy {
    rule {
      allowed_clients = "0.0.0.0/0"
      access= "ReadWrite"
      nfsv3 {
        checked =  true
      }
      nfsv4 {
        checked = false
      }
    }
    rule {
      allowed_clients= "10.0.0.0"
      access= "ReadWrite"
      nfsv3 {
        checked =  true
      }
      nfsv4 {
        checked = false
      }
    }
  }
}

# Create a snapshot tied to an volume
resource "netapp-gcp_snapshot" "gcp-snapshot" {
  name = "deleteme_asapGO_jusitin-snapshot"
  region = "us-west2"
  volume_name =  "deleteme_asapGO_jusitin"
  # creation_token = "unique-token-number"
}

# Create an Active Directory
resource "netapp-gcp_active_directory" "gcp-active-directory" {
  provider = netapp-gcp
  region = "us-west2"
	username = "test_user"
	password = "netapp"
  domain = "example.com"
  dns_server = "10.0.0.0"
  net_bios = "cvsserver"
}

# Create a volume_backup tied to an volume
resource "netapp-gcp_volume_backup" "gcp-volume-backup" {
  name = "main-volume-backup"
  region = "us-west2"
  volume_name =  "main-volume"
  creation_token = "unique-token-number"
}
