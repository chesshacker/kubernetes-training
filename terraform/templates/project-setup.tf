{% from 'modules/common.tf' import backend, provider %}
{{ backend(google, 'project-setup') }}
{{ provider(google) }}

resource "google_storage_bucket" "terraform_remote_state" {
  name     = "{{ google.project }}-terraform-remote-state"
  location = "US"

  versioning {
    enabled = "true"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_service_account" "circleci-infrastructure" {
  account_id   = "circleci-infrastructure"
  display_name = "Circle CI Infrastructure"
}

resource "google_project_iam_member" "circleci-infrastructure-iam" {
  project = "{{ google.project }}"
  role        = "roles/owner"
  member      = "serviceAccount:${google_service_account.circleci-infrastructure.email}"
}

resource "google_project_services" "project_services" {
  project = "{{ google.project }}"

  services = [
    "bigquery-json.googleapis.com",
    "cloudapis.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudtrace.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "datastore.googleapis.com",
    "deploymentmanager.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "pubsub.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "servicemanagement.googleapis.com",
    "serviceusage.googleapis.com",
    "sql-component.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com"
  ]
}

resource "google_project_iam_member" "is-devops-owner-iam" {
  project     = "{{ google.project }}"
  role        = "roles/owner"
  member      = "group:is-devops@heb.com"
}
