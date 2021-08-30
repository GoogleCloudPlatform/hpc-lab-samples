# Module secret



This module is used to create a secret in secret manager. Secret Manager allows you to store, manage, and access [secrets](https://cloud.google.com/secret-manager/docs/overview#secret) as binary blobs or text strings. With the appropriate permissions, you can view the contents of the secret.

# Example Usage

```
resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "billing-acct"
  project   = var.project_id


  replication {
      automatic = true
  }
}

resource "google_secret_manager_secret" "service-account" {
  secret_id = "service-acct"
  project   = var.project_id


  replication {
      automatic = true
  }
}
```



| Name    | Description                                | Type   | Default |
| ------- | ------------------------------------------ | ------ | ------- |
| project | project id (fetched from variable.tf file) | string | ""      |

- The following arguments are supported:
  - [`replication`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret#replication) - (Required) The replication policy of the secret data attached to the Secret. It cannot be changed after the Secret has been created. Structure is documented below.
  - [`secret_id`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret#secret_id) - (Required) This must be unique within the project.

The `replication` block supports:

The following arguments are supported:

- [`automatic`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret#automatic) - (Optional) The Secret will automatically be replicated without any restrictions.

  

## Outputs

| Name     | Description                              |
| -------- | ---------------------------------------- |
| contents | The actual value of the requested secret |



## Requirements

### Software

1. [Terraform](https://www.terraform.io/downloads.html) 0.10.x

2. [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) v1.10.0

   

### Permissions

| Role                                       | Title                                 | Description                                                | Permissions                                                  |
| ------------------------------------------ | ------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------ |
| roles/secretmanager.admin                  | Secret Manager Admin                  | Full access to administer  Secret Manager resources.       | resourcemanager.projects.get resourcemanager.projects.list secretmanager.* |
| `roles/secretmanager.secretAccessor`       | Secret Manager Secret Accessor        | Allows accessing the payload of secrets.                   | resourcemanager.projects.get resourcemanager.projects.list secretmanager.versions.access |
| `roles/secretmanager.secretVersionAdder`   | Secret Manager Secret Version Adder   | Allows adding versions to existing secrets.                | resourcemanager.projects.get resourcemanager.projects.list secretmanager.versions.add |
| `roles/secretmanager.secretVersionManager` | Secret Manager Secret Version Manager | Allows creating and managing versions of existing secrets. | resourcemanager.projects.get resourcemanager.projects.list secretmanager.versions.add secretmanager.versions.destroy secretmanager.versions.disable secretmanager.versions.enable secretmanager.versions.get secretmanager.versions.list |
| `roles/secretmanager.viewer`               | Secret Manager Viewer                 | Allows viewing metadata of all Secret Manager resources    | resourcemanager.projects.get resourcemanager.projects.list secretmanager.locations.* secretmanager.secrets.get secretmanager.secrets.getIamPolicy secretmanager.secrets.list secretmanager.versions.get secretmanager.versions.list |



### APIs

A project with the following APIs enabled must be used to host the resources of this module:

- Secret Manager API: `secretmanager.googleapis.com`

  
