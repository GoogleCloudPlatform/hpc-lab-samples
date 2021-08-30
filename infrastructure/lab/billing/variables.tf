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

variable "bill_account" {
  type = string
  default = "011776-B1E987-434528"
} 

variable "project_id" {
  type = string 
}

variable "budget_name" {
  type = string
  default = "HCL Budget"
}

variable "amount" {
  description = "The amount to use as the budget"
  type = string
  default = "1000"
}

variable "currency" {
  description = "The currency to use for the budget"
  type   = string
  default = "USD"
}

variable "email" {
  description = "The email for notifications"
  type   = string
  default = "zi.wangs@hcl.com"
}

variable "percent1" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type = number
  default = 0.5
}
variable "percent2" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type = number
  default = 0.75
}
variable "percent3" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type = number
  default = 0.8
}
variable "percent4" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type = number
  default = 1
}
