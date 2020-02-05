#!/bin/sh

cd "$(dirname "$0")"
mkdir -p output
rm -rf output/*

# Build terraform files
docker-compose run --rm jinja templates/main.tf config.yaml > output/main.tf
