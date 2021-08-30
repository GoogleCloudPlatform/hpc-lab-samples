variable "project" {
  type        = string
}

variable "display_name" {
  type        = string 
  default = "CPU utilization and Filestore"
}

variable "alert_combiner" {
  type        = string
  description = "Combiner of alert"
  default = "OR"
}

variable "duration" {
  type        = string
  description = "Duration of the condition"
  default = "60s"
}

variable "condition_comparison" {
  type        = string
  description = "Comparison such as greater than or lower than of the given condition"
  default     =  "COMPARISON_GT"
}

variable "aggregations_aligner" {
  type        = string
  description = "Aggregation aligner to be displayed"
  default  = "ALIGN_NONE"
}

variable "trigger_count" {
  type        = number
  description = "trigger count"
  default  = 1
}

variable "notification_email_addresses" {
  description = "The email for notifications"
  type   = list(string)
  default = ["zi.wang@hcl.com",]
}

variable "cpu_threshold" {
  default   = 0.5
}

variable "filestore_disk_threshold" {
  default   = 80
}
