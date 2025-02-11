# Deployment Documentation
## Prerequisites
- Terraform installed
- AWS CLI configured
- kubectl installed
- Docker installed

# Steps

## 1. Provision Infrastructure
    
- mkdir terraform
- cd terraform
- terraform init
- terraform apply -auto-approve



## 2. Build and push Docker image:
  
- docker build -t web-app1 .
- docker tag web-app1 <your-repo>/web-app1:latest
- docker push <your-repo>/web-app1:latest



## 3.	Deploy Web Application to Kubernetes
- kubectl apply -f deployment.yaml
- kubectl apply -f service.yaml



## 4.	Access the Application

- kubectl port-forward svc/web-app 80:80

Open http://localhost:80 in your browser.


## 5.	Set Up Monitoring

1.	Create the monitoring namespace:

- kubectl create namespace monitoring


2.	Apply all configurations:

- kubectl apply -f prometheus-config.yaml
- kubectl apply -f prometheus-deployment.yaml
- kubectl apply -f prometheus-service.yaml


3.	Verify the deployment:

- kubectl get pods -n monitoring


4.	Access Prometheus UI (Port-forwarding for local access):

- kubectl port-forward svc/prometheus-service -n monitoring 9090:9090

Open http://localhost:9090 in your browser.
	
