# Test Cluster

This project defines the infrastructure for testing out Kubernetes.

## Initial One-Time Project Setup

After running `../tooling/shell` to enter the shell, and assuming you are already logged in with gcloud...

```
gsutil mb -c standard -l us -p heb-sadc-training gs://heb-sadc-training-terraform-remote-state
rm -rf output
mkdir -p output
jinja2 templates/project-setup.tf test.yaml > output/project-setup.tf
cd output
terraform init
terraform import google_storage_bucket.terraform_remote_state heb-sadc-training-terraform-remote-state
terraform apply
cd ..
rm -rf output
```

## Typical Usage

After connecting to the shell (as above)...

```
./build.sh
cd output
terraform init
terraform plan
terraform apply
```
