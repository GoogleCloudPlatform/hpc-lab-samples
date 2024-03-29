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

data "google_billing_account" "account" {
  billing_account = var.bill_account
}

data "google_project" "project" {
}

resource "google_billing_budget" "budget" {
  billing_account = var.bill_account
  display_name    = var.budget_name

  budget_filter {
    projects = ["projects/${data.google_project.project.number}"]
    credit_types_treatment = "EXCLUDE_ALL_CREDITS"
  }

  amount {
    specified_amount {
      currency_code = var.currency
      units = var.amount
    }
  }

  threshold_rules {
    threshold_percent = var.percent1
  }
  threshold_rules {
    spend_basis = "FORECASTED_SPEND"
    threshold_percent = var.percent2
  }
  threshold_rules {
    spend_basis = "CURRENT_SPEND"
    threshold_percent = var.percent3
  }
  threshold_rules {
    spend_basis = "CURRENT_SPEND"
    threshold_percent = var.percent4
 }
  
  
  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.notification_channel.id,
    ]
    disable_default_iam_recipients = true
    
  }
}

resource "google_monitoring_notification_channel" "notification_channel" {
  display_name = "Notification Channel"
  type         = "email"

  labels = {
    email_address = var.email
  }
}