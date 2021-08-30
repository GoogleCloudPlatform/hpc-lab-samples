terraform {
  backend "gcs" {
    bucket  = "lab-common-bucket"
    prefix  = "admin/secret"
  }
}
