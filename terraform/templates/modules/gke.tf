{% macro gke(google, cluster) -%}

resource "google_container_cluster" "{{ cluster.name }}" {
  name                      = "{{ cluster.name }}"
  zone                      = "{{ cluster.zone }}"
{%- if cluster.additional_zones %}
  additional_zones          = {{ cluster.additional_zones | tojson }}
{%- endif %}
{%- if cluster.cluster_ipv4_cidr %}
  cluster_ipv4_cidr         = "{{ cluster.cluster_ipv4_cidr }}"
{%- endif %}
  remove_default_node_pool  = true   # remove default so cluster is not destroyed on node pool count changes
  initial_node_count        = 1      # must be set if node_pool is not declared
  network                   = "{{ cluster.network }}"
  subnetwork                = "{{ cluster.subnetwork }}"
  min_master_version        = "{{ cluster.min_master_version }}"
  monitoring_service        = "none"
  logging_service           = "none"

  addons_config {
    http_load_balancing {
      disabled = true
    }

    kubernetes_dashboard {
      disabled = true
    }
  }

  # Disable basic authentication
  # https://www.terraform.io/docs/providers/google/r/container_cluster.html#client_certificate_config
  # https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
  master_auth {
      username = ""
      password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "{{ cluster.name }}-default" {
  name               = "{{ cluster.name }}-default"
  cluster            = "${google_container_cluster.{{ cluster.name }}.name}"
  zone               = "{{ cluster.zone }}"
  initial_node_count = {{ cluster.min_node_count }}

  autoscaling {
    min_node_count = {{ cluster.min_node_count }}
    max_node_count = {{ cluster.max_node_count }}
  }

  node_config {
    preemptible  = true
    machine_type = "{{ cluster.machine_type }}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }
}
{%- endmacro -%}

{% macro gke_provider(cluster) -%}

provider "kubernetes" {
  version = "~> 1.4"
  host     = "https://${google_container_cluster.{{ cluster.name }}.endpoint}"
  username = "${google_container_cluster.{{ cluster.name }}.master_auth.0.username}"
  password = "${google_container_cluster.{{ cluster.name }}.master_auth.0.password}"

  client_certificate     = "${base64decode(google_container_cluster.{{ cluster.name }}.master_auth.0.client_certificate)}"
  client_key             = "${base64decode(google_container_cluster.{{ cluster.name }}.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.{{ cluster.name }}.master_auth.0.cluster_ca_certificate)}"
}

{%- endmacro -%}
