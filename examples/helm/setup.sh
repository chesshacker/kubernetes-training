#!/bin/sh

CLUSTER_NAME=test

# Get IP Address made with Terraform
export IP_ADDRESS=$(gcloud compute addresses describe \
  "${CLUSTER_NAME}-ingress-ip" \
  --project heb-sadc-training \
  --region us-central1 \
  --format="value(address)" )

gcloud container clusters get-credentials "${CLUSTER_NAME}" --zone us-central1-b --project heb-sadc-training
helm init --client-only
helm repo update
