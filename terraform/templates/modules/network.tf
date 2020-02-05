{% macro network(cluster, zone) -%}

resource "google_dns_managed_zone" "{{ zone.name }}" {
  name        = "{{ zone.name }}"
  dns_name    = "{{ zone.dns_name }}."
}

resource "google_compute_address" "{{ cluster.name }}_ingress_ip" {
  name         = "{{ cluster.name }}-ingress-ip"
}

resource "google_dns_record_set" "gke_{{ cluster.name }}_ingress_dns_record" {
  name         = "*.${google_dns_managed_zone.{{ zone.name }}.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = "${google_dns_managed_zone.{{ zone.name }}.name}"
  rrdatas      = ["${google_compute_address.{{ cluster.name }}_ingress_ip.address}"]
}

{%- endmacro -%}
