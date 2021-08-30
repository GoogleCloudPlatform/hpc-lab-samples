# Module cloudbuild



This module is used to instantiate cloud build trigger. The moment a new file is committed in repository it will trigger the build. The advantage of terraform state will prevail and only new resources will be added

# Example Usage

```
resource "google_cloudbuild_trigger" "filename-trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = "infrastructure"
  }

  filename = "cloudbuild.yaml"
  project = var.project_id
}
```



| Name        | Description                                | Type   | Default           |
| ----------- | ------------------------------------------ | ------ | ----------------- |
| repo_name   | Name of the repository.                    | string | "infrastructure"  |
| branch_name | Brach of the repository.                   | string | "master"          |
| filename    | name of the file                           | string | "cloudbuild.yaml" |
| project     | project id (fetched from variable.tf file) | string | ""                |

The `trigger_template` block supports:

- [`branch_name`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#branch_name) - (Optional) Name of the branch to build. Exactly one a of branch name, tag, or commit SHA must be provided. This field is a regular expression.
- [`repo_name`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#repo_name) - (Optional) Name of the Cloud Source Repository. If omitted, the name "default" is assumed.

Argument Reference

The following arguments are supported:

- [`filename`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#filename) - (Optional) Path, from the source root, to a file whose contents is used for the template. Either a filename or build template must be provided.
- [`project`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#project) - (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used. 

## Outputs

| Name                            | Description                                                  |
| ------------------------------- | ------------------------------------------------------------ |
| cloudbuild_project_id           | Project where CloudBuild configuration and terraform container image will reside. |
| gcs_bucket_cloudbuild_artifacts | Bucket used to store Cloud/Build artefacts in CloudBuild project. |



## Requirements

### Software

1. [gcloud sdk](https://cloud.google.com/sdk/install) >= 206.0.0
2. [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
3. [terraform-provider-google] plugin 3.50.x

### Permissions

- `roles/billing.user` on supplied billing account
- `roles/resourcemanager.organizationAdmin` on GCP Organization
- `roles/resourcemanager.projectCreator` on GCP Organization or folder

### APIs

A project with the following APIs enabled must be used to host the resources of this module:

- Google Cloud Resource Manager API: `cloudresourcemanager.googleapis.com`
- Google Cloud Billing API: `cloudbilling.googleapis.com`
- Google Cloud IAM API: `iam.googleapis.com`
- Google Cloud Storage API `storage-api.googleapis.com`
- Google Cloud Service Usage API: `serviceusage.googleapis.com`
- Google Cloud Build API: `cloudbuild.googleapis.com`
- Google Cloud Source Repo API: `sourcerepo.googleapis.com`

This API can be enabled in the default project created during establishing an organization.