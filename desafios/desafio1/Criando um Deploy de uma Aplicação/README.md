# Kubernetes Training Application

## Overview

This project demonstrates a simple application deployed on Kubernetes, consisting of a frontend, backend, and database. The frontend allows users to submit messages, which are then stored in a MySQL database via a PHP backend.

<div align="center">
    <img src="assets/frontend form.png" alt="Frontend Form Image"/>
</div>

## Components

- **Frontend:** A simple HTML form that allows users to input their name and message. It uses JavaScript to send the data to the backend.
- **Backend:** A PHP application that receives data from the frontend and stores it in the MySQL database.
- **Database:** A MySQL database that stores the messages submitted by users.

## Technologies Used

- Kubernetes
- Docker
- MySQL
- PHP
- HTML
- CSS
- JavaScript
- jQuery

## Prerequisites

- Kubernetes cluster
- Docker installed
- kubectl installed and configured

## Setup Instructions

1.  **Clone the repository:**

    ```bash
    git clone <repository_url>
    cd <project_directory>
    ```

2.  **Build Docker images:**

    ```bash
    docker build -t williamlima/project-database:1.0 ./database
    docker build -t williamlima/project-backend:1.0 ./backend
    ```

3.  **Push Docker images to Docker Hub:**

    ```bash
    docker push williamlima/project-database:1.0
    docker push williamlima/project-backend:1.0
    ```

    _Note: Replace `williamlima` with your Docker Hub username._

4.  **Deploy to Kubernetes:**

    ```bash
    kubectl apply -f ./database/db-service.yaml
    kubectl apply -f ./database/db-deploy.yaml
    kubectl apply -f ./backend/php-service.yaml
    kubectl apply -f ./backend/php-deploy.yaml
    ```

## Configuration

- **Database:**
  - The database deployment uses the image `williamlima/project-database:1.0`.
  - The database service exposes port 3306.
  - The root password for the MySQL database is set to `password`.
  - The database name is `dataset`.
- **Backend:**
  - The backend deployment uses the image `williamlima/project-backend:1.0`.
  - The backend service exposes port 80.
- **Frontend:**
  - The frontend's `scripts.js` file contains the backend URL (`http://35.224.5.250:30005/`). This should be updated to reflect the actual backend service URL after deployment. You can obtain this from your Kubernetes cluster.

## Database Initialization

The `database/sql.sql` file contains the SQL script to create the `messages` table:

```sql
CREATE TABLE messages (
    id int,
    user_name varchar(50),
    user_message varchar(100)
);
```

## Backend Connection

The `backend/connection.php` file contains the database connection details:

```php
<?php

$servername = "mysql-connection";
$username = "root";
$password = "password";
$database = "dataset";

// Criar conexão
$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

?>
```

## Accessing the Application

After deploying the application to Kubernetes, you can access the frontend through the LoadBalancer service. The exact steps depend on your Kubernetes environment (e.g., Minikube, cloud provider). Typically, you would:

1.  Get the external IP address or hostname assigned to the `php-service` LoadBalancer.
2.  Access the application in your web browser using that address.

## Notes

- The provided `script.bat` and `script.sh` files automate the Docker image building and pushing process. However, the `kubectl apply` commands in those scripts refer to `db-services.yaml` and `php-services.yaml` which are named `db-service.yaml` and `php-service.yaml` respectively.
- The frontend currently points to a hardcoded IP address (`http://35.224.5.250:30005/`). This will need to be updated to the correct address of the backend service after deployment.
- Consider using Kubernetes Secrets to manage sensitive information like database passwords.

## Contributing

Feel free to contribute to this project by submitting pull requests. If you find any issues or have suggestions for improvements, please create an issue.
