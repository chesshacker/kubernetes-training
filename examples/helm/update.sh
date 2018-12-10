#!/bin/sh

cd "$(dirname "$0")"

if [ -z "${IP_ADDRESS}" ]; then
  echo "IP address not found"
  exit 1
fi

if [ -z "${DATADOG_API_KEY}" ]; then
  echo "Error: Missing DATADOG_API_KEY=..."
  exit 1
fi

# datadog
helm upgrade --install \
  --namespace kube-system \
  --values values/datadog-agent.yaml \
  --set datadog.apiKey=${DATADOG_API_KEY} \
  --set clusterAgent.token=${DATADOG_API_KEY} \
  datadog-agent stable/datadog

# nginx ingress
helm upgrade --install \
  --namespace kube-system \
  --set controller.service.loadBalancerIP=${IP_ADDRESS} \
  --wait \
  nginx-ingress stable/nginx-ingress

# cert manager
helm upgrade --install \
  --namespace kube-system \
  --values values/cert-manager.yaml \
  --wait \
  cert-manager stable/cert-manager
kubectl apply -f manifests/cert-manager-issuer.yaml
