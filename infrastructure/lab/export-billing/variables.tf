#To create dataset id
variable "dataset_id" {
  description = "id of dataset"
  type        = string
  default     = "billingExportDataset"
}

#Location where dataset should be 
variable "location" {
  description = "location of dataset"
  type        = string
  default     = "US"
}

#Name of the  sink
variable "name" {
  description = "Name of the sink"
  type        = string
  default     = "billignSink"
}

#Billing account number 
variable "billing_account" {
  description = "Billing account number"
  type        = string
}

variable "project" {
  type        = string
}