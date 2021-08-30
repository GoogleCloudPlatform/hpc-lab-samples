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

locals {
  project_name = "${var.partner_name}-${var.sub_project}"
}

provider "google" {
  project = "${local.project_name}"
  impersonate_service_account = "terraform@lab-common.iam.gserviceaccount.com"
}

terraform {
  backend "gcs" { 
  }
}

module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 10.1"

  name              = "${local.project_name}"
  random_project_id = false
  folder_id         = "${var.project_folder_id}"
  org_id            = "${var.project_org_id}"
  billing_account   = "${var.project_billing_id}"
  default_service_account = var.default_service_account
  labels            = {
    "partner" = "${var.partner_name}"
    "sandbox" = "${var.partner_name}"
  }
}

module "service-enablement"  {
  source    = "../../lab/service-enablement"
  project   = module.project-factory.project_id
  gcp_service_list= var.gcp_service_list
  depends_on = [
    module.project-factory
  ]
}

module "landing-zone" {
  source          = "../../lab/landing-zone"
  project         = module.project-factory.project_id
  location        = "${var.region}"
  primarycidr     = var.primarycidr
  secondarycidr   = var.secondarycidr
  depends_on = [
    module.service-enablement
  ]
}

module "billing-alert" {
  source            = "../../lab/billing"
  bill_account   = "${var.project_billing_id}"
  project_id        = module.project-factory.project_id
  depends_on = [
    module.service-enablement
  ]
}

module "alert-monitoring" {
  source    = "../../lab/alerts-and-monitoring"
  project   = module.project-factory.project_id
  depends_on = [
    module.service-enablement
  ]
}

# module "filestore-server" {
#   source    = "../../lab/terraform/storage"
#   project   = module.project-factory.project_id
#   zone      = "${var.zone}"
#   network   = "default"
#   depends_on = [
#     module.service-enablement,
#     module.landing-zone
#   ]
# }

module "nfs-server" {
  source            = "../../lab/nfs-server"
  project_id        = module.project-factory.project_id
  zone              = "${var.zone}"
  depends_on = [
    module.landing-zone
  ]
}

module "slurm-cluster" {
  source    = "../../lab/terraform/slurm-cluster"
  project   = module.project-factory.project_id
  zone      = "${var.zone}"
  cluster_name = "edafarm"

  network_name            = var.network
  subnetwork_name         = var.sub_network
  slurm_version           = var.slurm_version
  controller_scopes          = ["https://www.googleapis.com/auth/cloud-platform"]
  login_node_scopes          = ["https://www.googleapis.com/auth/cloud-platform"]

  network_storage = [{
      server_ip     = module.nfs-server.home-volume-ip-addresses
      remote_mount  = "/home"
      local_mount   = "/home"
      fs_type       = "nfs"
      mount_options = "defaults,hard,intr"
    },{
      server_ip     = module.nfs-server.tools-volume-ip-addresses
      remote_mount  = "/tools"
      local_mount   = "/tools"
      fs_type       = "nfs"
      mount_options = "defaults,hard,intr"
  }]

  partitions = [
    { name                 = "debug"
      machine_type         = var.machine_type
      static_node_count    = 0
      max_node_count       = var.max_node_count
      zone                 = var.zone
      compute_disk_type    = var.compute_disk_type
      compute_disk_size_gb = var.compute_disk_size_gb
      compute_labels       = {}
      cpu_platform         = null
      gpu_count            = 0
      gpu_type             = null
      network_storage      = []
      preemptible_bursting = var.preemptible_bursting
      vpc_subnet           = var.sub_network
    },
  ]

  depends_on = [
    # module.filestore-server,
    module.nfs-server
  ]
}

