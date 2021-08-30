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