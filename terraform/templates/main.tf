{% from 'modules/common.tf' import backend, provider %}
{{ backend(google, terraform.prefix) }}
{{ provider(google) }}

# Kubernetes Cluster
{% from 'modules/gke.tf' import gke, gke_provider %}
{{ gke(google, cluster) }}

# Network
{% from 'modules/network.tf' import network %}
{{ network(cluster, dnsZone) }}
