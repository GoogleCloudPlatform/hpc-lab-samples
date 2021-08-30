# variable declarations

variable "region" {
    default = "us-central1"
    type = string    
}

variable "zone" {
    default = "us-central1-a"
    type = string    
}

variable "partner_name" {
    default = "google-internal"
    type = string    
}

variable "sub_project" {
    default = "pocsample"
    type = string    
}

variable "project_folder_id" {
    description = "Project folder Id"
    type = string
    default = "334844278185"
}

variable "project_org_id" {
    description = "Project org Id"
    type = string
    default = "492164933588"
}

variable "project_billing_id" {
    description = "Project Billing Id"
    type = string
    default = "011776-B1E987-434528"
}

variable "default_service_account" {
  description = "Project default service account setting: can be one of `delete`, `deprivilege`, `disable`, or `keep`."
  default     = "keep"
  type        = string
}

variable "network" {
    default = "default"
    type = string    
}

variable "sub_network" {
    default = "default"
    type = string    
}

variable "slurm_version" {
    default = "b:slurm-19-05-8-1"
    # default = "b:slurm-20.11"
    type = string    
}

variable "machine_type" {
    default = "n1-standard-2"
    type = string    
}

variable "gcp_service_list" {
  type = list(string)
  default = [
    "file.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "sourcerepo.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "bigquery.googleapis.com"
  ]
}
variable "primarycidr" {
  type  = string
  default = "10.0.0.0/24" 
}

variable "secondarycidr" {
  type  = string
  default = "10.2.0.0/24" 
}

variable compute_disk_size_gb {
    default = 20
}

variable compute_disk_type{
    default = "pd-standard"
}

variable max_node_count {
    default = 10
}

variable preemptible_bursting {
    type = bool
    default = true
}