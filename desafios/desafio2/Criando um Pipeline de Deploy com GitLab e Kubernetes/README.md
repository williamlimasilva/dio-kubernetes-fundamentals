# Kubernetes Deployment with GitLab CI/CD Pipeline

This project demonstrates how to create an automated deployment pipeline for a containerized PHP application with a MySQL database using GitLab CI/CD and Kubernetes. The pipeline builds Docker images, pushes them to Docker Hub, and deploys the application to a Kubernetes cluster.

## Project Overview

This project implements a continuous integration and continuous deployment (CI/CD) workflow that automates the build and deployment process of a web application. When code changes are pushed to the GitLab repository, the pipeline automatically:

1. Builds Docker images for the application
2. Pushes the images to Docker Hub
3. Deploys the application to a Kubernetes cluster via SSH

## Directory Structure

```
dio-kubernetes-fundamentals/
│
├── .gitlab-ci.yml              # GitLab CI/CD pipeline configuration
├── script.sh                   # Kubernetes deployment script
├── secrets.yml                 # Kubernetes secrets configuration
│
├── app/                        # Application components
│   ├── backend/                # PHP application
│   │   ├── php-deploy.yaml     # Kubernetes deployment for PHP
│   │   └── php-service.yaml    # Kubernetes service for PHP
│   │
│   └── database/               # MySQL database
│       ├── db-deploy.yaml      # Kubernetes deployment for MySQL
│       ├── db-pvc.yaml         # Persistent Volume Claim for MySQL
│       └── db-service.yaml     # Kubernetes service for MySQL
│
└── docs/                       # Documentation
    └── guide.md                # Docker and Kubernetes guide
```

## Architecture

The application follows a two-tier architecture:

1. **Frontend/Backend Tier**: PHP application served by Apache (container)
2. **Database Tier**: MySQL database (container)

Both components are containerized using Docker and orchestrated with Kubernetes. The components communicate through Kubernetes services.

### Components

- **PHP Application**: Serves the web application through Apache, with 3 replicas for high availability
- **MySQL Database**: Persistent database with volume mounting for data persistence
- **Kubernetes Services**: Expose the applications within the cluster and to external users
- **GitLab CI/CD**: Automates the build and deployment process

## CI/CD Pipeline

The pipeline is defined in `.gitlab-ci.yml` and consists of two stages:

1. **Build Stage**:

   - Uses Docker-in-Docker (DinD) to build the application image
   - Pushes the image to Docker Hub with appropriate tags

2. **Deploy Stage**:
   - Connects to the Kubernetes cluster via SSH
   - Clones the repository on the cluster
   - Executes `script.sh` to apply Kubernetes configurations

## Technologies Used

- **Containerization**: Docker
- **Container Registry**: Docker Hub
- **CI/CD**: GitLab CI/CD
- **Orchestration**: Kubernetes
- **Languages**: PHP, Bash
- **Database**: MySQL 5.7
- **Web Server**: Apache

## Design Patterns

1. **Microservice Architecture**: Application components are divided into separate services
2. **Immutable Infrastructure**: Container images are versioned and immutable
3. **Configuration as Code**: Infrastructure defined as YAML files
4. **Separation of Concerns**: Clear division between application, database, and deployment
5. **12-Factor App Methodology**: Environment variables for configuration

## Deployment Process

1. Code is pushed to GitLab repository
2. GitLab CI/CD pipeline is triggered
3. Docker image is built and pushed to Docker Hub
4. SSH connection is established with the GCP VM
5. Kubernetes manifests are applied to the cluster
6. Application is deployed with specified replicas and configurations

## Security Considerations

- Sensitive data (database password, connection strings) stored as Kubernetes secrets
- SSH key-based authentication for deployment
- Restricted permissions on deployment scripts
- Image pull policies to ensure using the correct versions

## Prerequisites

- Kubernetes cluster (GCP or similar)
- GitLab account with CI/CD capabilities
- Docker Hub account
- SSH access to the deployment server

## Local Development

For local testing, you can use:

```bash
# Build the Docker image
docker build -t williamlimasilva/dio-kubernetes-fundamentals:1.0 app/.

# Run the container locally
docker run -p 80:80 williamlimasilva/dio-kubernetes-fundamentals:1.0
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a pull request
