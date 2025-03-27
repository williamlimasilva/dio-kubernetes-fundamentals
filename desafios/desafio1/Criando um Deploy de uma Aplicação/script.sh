#!/bin/bash

echo "------------- Starting Kubernetes Build -------------"
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

echo "Creating Database services on Kubernetes Cluster..."
kubectl apply -f ./database/db-services.yaml
echo "Database services created successfully on Kubernetes Cluster!!"

echo "Creating Database deployment on Kubernetes Cluster..."
kubectl apply -f ./database/db-deploy.yaml
echo "Database deployment created successfully on Kubernetes Cluster!!"

echo "Creating Backend services on Kubernetes Cluster..."
kubectl apply -f ./backend/php-services.yaml
echo "Backend services created successfully on Kubernetes Cluster!"

echo "Creating Backend deployment on Kubernetes Cluster..."
kubectl apply -f ./backend/php-deploy.yaml
echo "Backend deployment created successfully on Kubernetes Cluster!"

echo "All Done - Kubernetes Cluster created successfully!"

echo "------------- Kubernetes Build Finished -------------"