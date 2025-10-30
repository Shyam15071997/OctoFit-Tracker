# Deployment Instructions for FitLearn Platform

This document provides instructions for deploying the FitLearn platform, which includes a Django REST API backend, a React frontend, and a MongoDB database. The deployment can be done using Docker, Kubernetes, or Terraform.

## Prerequisites

- Docker installed on your machine
- Kubernetes cluster (e.g., Minikube, GKE, EKS)
- Terraform installed
- Access to a MongoDB instance

## Docker Deployment

1. **Build Docker Images**

   Navigate to the backend and frontend directories and build the Docker images:

   ```bash
   cd backend
   docker build -t fitlearn-backend .

   cd ../frontend
   docker build -t fitlearn-frontend .
   ```

2. **Run Docker Containers**

   Use Docker Compose to run the application:

   ```bash
   cd ../infra
   docker-compose up
   ```

   This will start the backend, frontend, and MongoDB services.

## Kubernetes Deployment

1. **Deploy MongoDB**

   Apply the MongoDB deployment configuration:

   ```bash
   kubectl apply -f k8s/mongo-deployment.yaml
   ```

2. **Deploy Backend**

   Apply the backend deployment configuration:

   ```bash
   kubectl apply -f k8s/backend-deployment.yaml
   ```

3. **Deploy Frontend**

   Apply the frontend deployment configuration:

   ```bash
   kubectl apply -f k8s/frontend-deployment.yaml
   ```

4. **Access the Application**

   Use `kubectl port-forward` to access the frontend service:

   ```bash
   kubectl port-forward svc/fitlearn-frontend 3000:80
   ```

   You can now access the application at `http://localhost:3000`.

## Terraform Deployment

1. **Initialize Terraform**

   Navigate to the Terraform directory and initialize:

   ```bash
   cd infra/terraform
   terraform init
   ```

2. **Plan the Deployment**

   Review the resources that will be created:

   ```bash
   terraform plan
   ```

3. **Apply the Deployment**

   Deploy the resources:

   ```bash
   terraform apply
   ```

## Environment Variables

Ensure to set the necessary environment variables in a `.env` file or directly in your deployment configurations. Refer to the `.env.example` file for required variables.

## Conclusion

Follow these instructions to successfully deploy the FitLearn platform. For further customization and scaling, refer to the respective documentation for Docker, Kubernetes, and Terraform.