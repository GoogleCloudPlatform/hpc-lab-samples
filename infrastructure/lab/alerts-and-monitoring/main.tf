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

resource "google_monitoring_notification_channel" "notification_channel" {
  count        = "${length(var.notification_email_addresses)}"
  project      = "${var.project}"
  enabled      = true
  display_name = "Send email to ${element(var.notification_email_addresses, count.index)}"
  type         = "email"

  labels = {
    email_address = "${element(var.notification_email_addresses, count.index)}"
  }
}


resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = var.display_name
  combiner     = var.alert_combiner
  notification_channels = "${google_monitoring_notification_channel.notification_channel.*.name}"
  
  
  conditions   {
    display_name = "Alert on cpu utilization"
    
    condition_threshold  {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      
      duration        = var.duration
      comparison      = var.condition_comparison
      threshold_value = var.cpu_threshold
      trigger {
        count = var.trigger_count
      }
      aggregations {
        alignment_period   = var.duration
        per_series_aligner = var.aggregations_aligner
      }
    }
  
  }

  conditions   {
    display_name = "Alert for used disk space for filestore"
        
    condition_threshold  {
      filter          = "metric.type=\"file.googleapis.com/nfs/server/used_bytes_percent\" AND resource.type=\"filestore_instance\""
      
      duration        = var.duration
      comparison      = var.condition_comparison
      threshold_value = var.filestore_disk_threshold
      trigger {
        count = var.trigger_count
      }
      aggregations {
        alignment_period   = var.duration
        per_series_aligner = var.aggregations_aligner
      }
    }
  }
}