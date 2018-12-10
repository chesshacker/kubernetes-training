# GitLab Test Cluster Workloads

One-time set up of tiller, use the `../tooling/shell` 

```
gcloud container clusters get-credentials test --zone us-central1-b --project heb-sadc-training
kubectl apply -f manifests/tiller-rbac.yaml
helm init --service-account tiller --upgrade
```

## Typical Usage

After connecting to the shell (as above)...

```
. setup.sh
export DATADOG_API_KEY=xxx
./update.sh
```
