#!/bin/sh

cd "$(dirname "$0")"
mkdir -p output
rm -rf output/*

#Build terraform files
jinja2 templates/main.tf config.yaml > output/main.tf
