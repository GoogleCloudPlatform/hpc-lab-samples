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

resource "google_bigquery_dataset" "dataset" {
  project                     = var.project
  dataset_id                  = var.dataset_id
  location                    = var.location
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bqowner.email
  }

  access {
    role   = "READER"
    domain = "hashicorp.com"
  }
}

resource "google_service_account" "bqowner" {
  account_id = "bqowner"
  project    = var.project
}

# 
resource "google_logging_billing_account_sink" "my-sink" {
  name            = var.name
  description = "sink for gathering billing information from a billing account"
  billing_account = var.billing_account

   # Export to bigquery
  destination = "bigquery.googleapis.com/projects/${var.project}/datasets/${google_bigquery_dataset.dataset.dataset_id}"
}              

resource "google_project_iam_binding" "log-writer" {
  role = "roles/storage.objectCreator"

  members = [
    google_logging_billing_account_sink.my-sink.writer_identity,
  ]
}
