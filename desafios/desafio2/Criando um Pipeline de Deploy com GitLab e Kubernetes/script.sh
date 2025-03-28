#!/bin/bash

echo "------------- Starting Kubernetes Build -------------"

# Apply secrets first
echo "Creating Kubernetes secrets..."
kubectl apply -f ./secrets.yaml
echo "Secrets created successfully!"

echo "Creating Docker image for database..."
docker build -t williamlima/project-database:1.0 ./database
echo "Database image created successfully!"

echo "Creating Docker image for backend..."
docker build -t williamlima/project-backend:1.0 ./backend
echo "Backend image created successfully!"

echo "Pushing Docker images to Docker Hub..."

docker push williamlima/project-database:1.0
echo "Docker Database Image pushed successfully!"

docker push williamlima/project-backend:1.0
echo "Docker Backend Image pushed successfully!"

echo "Creating services on Kubernetes Cluster..."

echo "Creating Database PersistentVolumeClaim on Kubernetes Cluster..."
kubectl apply -f ./app/database/db-pvc.yaml --record
echo "Database PersistentVolumeClaim created successfully on Kubernetes Cluster!!"

echo "Creating Database Deployment on Kubernetes Cluster..."
kubectl apply -f ./app/database/db-deploy.yaml --record
echo "Database deployment created successfully on Kubernetes Cluster!!"

echo "Creating Database Services on Kubernetes Cluster..."
kubectl apply -f ./app/database/db-service.yaml --record
echo "Database services created successfully on Kubernetes Cluster!!"

echo "Creating Backend Deployment on Kubernetes Cluster..."
kubectl apply -f ./app/backend/php-deploy.yaml --record
echo "Backend Deployment created successfully on Kubernetes Cluster!"

echo "Creating Backend Services on Kubernetes Cluster..."
kubectl apply -f ./app/backend/php-service.yaml --record
echo "Backend Services created successfully on Kubernetes Cluster!"

echo "All Done - Kubernetes Cluster created successfully!"

# Get external IP address for the service
echo "Waiting for external IP to be assigned..."
sleep 10
EXTERNAL_IP=$(kubectl get service php-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "Your application is available at: http://$EXTERNAL_IP"

echo "------------- Kubernetes Build Finished -------------"