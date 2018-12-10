{% macro backend(google, prefix) -%}

terraform {
  backend "gcs" {
    bucket  = "{{ google.project }}-terraform-remote-state"
    prefix  = "{{ prefix }}"
  }
}

{%- endmacro -%}

{%- macro provider(google) -%}

provider "google" {
  version = "~> 1.19"
  project = "{{ google.project }}"
  region  = "{{ google.region }}"
}

{%- endmacro -%}

{%- macro project() -%}
data "google_project" "project" {

}
{%- endmacro -%}
