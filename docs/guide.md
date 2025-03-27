# Kubernetes Deployment Guide

## Working with Kubernetes

### Get Nodes

```bash
kubectl get nodes
```

### Create a Deployment

Create a YAML file named `simple-deployment.yaml` with the following content:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-html-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app-html
  template:
    metadata:
      labels:
        app: app-html
    spec:
      containers:
        - name: app-html
          image: httpd:latest
          ports:
            - containerPort: 80
```

Apply the deployment:

```bash
kubectl apply --filename=simple-deployment.yaml
```

### Check Pods and Deployments

List all pods:

```bash
kubectl get pods
```

List pods with detailed information:

```bash
kubectl get pods --output='wide'
```

Describe a specific pod:

```bash
kubectl describe pods [name]
```

List all deployments:

```bash
kubectl get deployments
```

### Expose the Deployment

Expose the deployment as a LoadBalancer service:

```bash
kubectl expose deployments app-html-deployment --type=LoadBalancer --name=app-html --port=80
```

List all services:

```bash
kubectl get services
```

#### If External IP is Not Shown (Using Minikube)

Use the following command to get the service URL:

```bash
minikube service --url app-html
```

Test the service using `curl`:

```bash
curl [address example: http://192.168.59.101:30806]
```

---

## Creating a Docker Image

### Create an Example HTML File

Create a file named `index.html` with the following content:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kubernetes App</title>
  </head>
  <body>
    <h1>Hello Kubernetes!</h1>
  </body>
</html>
```

### Create a Dockerfile

Create a file named `Dockerfile` with the following content:

```dockerfile
FROM httpd:latest

WORKDIR /usr/local/apache2/htdocs

COPY index.html /usr/local/apache2/htdocs/

EXPOSE 80
```

### Build the Docker Image

Build the Docker image using the following command:

```bash
docker build -t williamlima/app-html:1.0 .
```

### Login to Docker Hub

Login to Docker Hub:

```bash
docker login
```

### Push the Docker Image to Docker Hub

Push the Docker image to Docker Hub:
**_Example_**

```bash
docker push williamlimasilva/app-html:1.0
```

## Opening a Shell in a Running Container

```bash
kubectl exec --stdin --tty [pod-name] -- /bin/bash
```

## Port Forwarding

**_Example_**

```bash
kubectl port-forward pod/mysql 3306:3306
```
## Resource limits
```bash
kubectl apply -f [file] --record
```
## Rollback
```bash
kubectl rollout undo deployment [deployment-name] --to-revision=[revision-number]
``` 
## Autoscaling
```bash
kubectl autoscale deployment [deployment-name] --min=[min-pods] --max=[max-pods] --cpu-percent=[cpu-percent]
```
## Secrets
```bash
kubectl create secret generic [secret-name] --from-literal=[key]=[value]
```
## ConfigMap
```bash
kubectl create configmap [configmap-name] --from-literal=[key]=[value]
```
## Helm
```bash
helm install [chart-name] [repo-name]
```
## Helm Upgrade
```bash
helm upgrade [chart-name] [repo-name]
```
## Helm Rollback
```bash
helm rollback [chart-name] [repo-name]
```



