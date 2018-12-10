# Kubernetes Training

Steve Ortiz

---

## Lab: Build a Cluster

---

## Origins

* Kubernetes came from Google
* Borg - Omega - Kubernetes
* Open-sources in the Summer of 2014
* Cloud Native Computing Foundation (CNCF)

---

## What is it?

* **Orchestrator** for your data center
* Standard for **Cloud Native**
* Works across clouds and on-prem
* Lots of momentum

---

## OS for Data Centers

* Pets vs Cattle
  - Don't care about the name of a server
  - Don't manage LUNs in a spreadsheet
  - IP addresses churn constantly
* View your data center as one large computer
* Let Kubernetes manage the details

---

## Terminology

* Cluster, Nodes, Master, Worker
* Pod, Service, Volume, Namespace
* Deployment, ReplicaSet
* StatefulSet, DaemonSet, Job
* ConfigMap, Secret
* kubelet, kube-proxy

---

![](assets/kubernetes-architecture.png) <!-- .element width="75%" -->

---

## Whiteboard: Wordpress

---

## Deploy Wordpress in Kubernetes

---

## Kubernetes API

* REST - Create Read Update Delete
* Declarative configuration - desired state
* Core API Group "", apps, authorization, storage
* API Groups map to Special Interest Groups SIGs
* Versions: v1alpha1, v2beta1, v1

---

## kubectl Completion

```bash
echo "source <(kubectl completion bash)" >> ~/.bashrc
```

---

## Commands to Try

```bash
kubectl help
kubectl version -o yaml
kubectl get apiservices
kubectl api-resources # newer clients only
kubectl explain
```

---

## Kubernetes Version

```bash
kubectl version -o json | jq '.serverVersion'
```

```json
{
  "major": "1",
  "minor": "10",
  "gitVersion": "v1.10.3",
  "gitCommit": "2bba0127d85d5a46ab4b778548be28623b32d0b0",
  "gitTreeState": "clean",
  "buildDate": "2018-05-21T09:05:37Z",
  "goVersion": "go1.9.3",
  "compiler": "gc",
  "platform": "linux/amd64"
}```

[Kubernetes v1.10.3](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3)

---

## Kubernetes API Reference

<https://kubernetes.io/docs/reference/>

---

## Apps

* Deployments, DaemonSets, StatefulSets
* Which are made up of replicasets and pods

---

## App related commands

```bash
kubectl create deployment --image=nginx:alpine my-nginx \
  -o yaml --dry-run > nginx-deployment.yaml
kubectl apply -f nginx-deployment.yaml
kubectl get replicasets
kubectl get pods
kubectl describe pods
kubectl logs
kubectl exec
kubectl port-forward
kubectl cp
kubectl delete deployment my-nginx
```

---

## Lab: Example Website

---

## Deployments

* Liveness and Readiness probes [docs](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/)
  - exec, tcpSocket, httpGet
* Resource requests / limits [docs](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/)

---

## Lab: Example Koa App

---

## Networking

* **ClusterIP:** Stable IP address assigned to a Service
* **Pod IP:** Ephemeral IP address assigned to a given Pod
* **Node IP:** IP address assigned to a Worker Node
* Others: Master API and any Load Balancers

---

## Services

* Service uses selectors and labels
* Service types are ClusterIP, NodePort, LoadBalancer
* Service networks are not real networks
  - pre 1.11, kube-proxy uses IP tables to rewrite requests
  - later uses IP Virtual Server (IPVS)
* Services are stable. Each service creates an endpoint list.

---

## Service related Commands

```bash
kubectl expose deployment my-nginx --port=80 --type=LoadBalancer \
 -o yaml --dry-run > nginx-service.yaml
 kubectl apply -f nginx-service.yaml
kubectl get svc
kubectl describe svc
```

---

## Storage

* persistent volumes, persistent volume claims and storage classes
* CSI Container Storage Interface

---

## Lab: Create Volumes

---

## More ways to Configure

* ConfigMap
* Secret

---

## Lab: Use a ConfigMap for index.html

---

## Authentication

* CA certificate and token
* Namespaces, Roles and RoleBinding

---

## Lab: Create Namespace and Service Account

---

## Lab: Helm

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
```

---

## And More

* Jobs
* ScheduledJobs
* Horizontal Pod Autoscalers
* Operators
* Custome Resource Definitions
* Service Mesh - Istio
* Knative (Serverless)
* OpenShift
