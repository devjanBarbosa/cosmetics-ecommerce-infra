# Cosmetics E-Commerce | AWS Infrastructure as Code ☁️

This repository contains the Infrastructure as Code (IaC) required to provision and manage the cloud environment for a full-stack cosmetics e-commerce application. The architecture migrates the original application from PaaS platforms (Heroku and Vercel) to a highly available, secure, and scalable environment on Amazon Web Services (AWS).

**Status:** Active Development 🚧

## 🎯 Architecture Overview

The infrastructure isolates the backend and database within a custom Virtual Private Cloud (VPC), while serving the frontend globally via a Content Delivery Network (CDN). 

* **Frontend:** Angular application hosted on Amazon S3 and distributed via Amazon CloudFront.
* **Backend:** Java Spring Boot REST API running on containerized Amazon ECS (Fargate), positioned behind an Application Load Balancer (ALB) in a public subnet.
* **Database:** Relational database managed by Amazon RDS, secured within private subnets.

## 🛠️ Tech Stack & Services

| Category | Technology / AWS Service | Purpose |
| :--- | :--- | :--- |
| **IaC** | HashiCorp Terraform | Infrastructure provisioning and state management |
| **Networking** | Amazon VPC, IGW, Subnets | Network isolation and routing |
| **Compute** | Amazon ECS (Fargate), ALB | Serverless container execution and load balancing |
| **Database** | Amazon RDS | Managed relational database |
| **Storage & CDN** | Amazon S3, CloudFront | Static asset hosting and global distribution |

## 📂 Repository Structure

The code is organized to maintain a clean separation of concerns:

* `provider.tf` - Cloud provider configuration (AWS) and required versions.
* `main.tf` - Core infrastructure resources (VPC, Subnets, Gateways, Compute).
* `variables.tf` - Input variables for environment customization.
* `outputs.tf` - Provisioned endpoints (e.g., ALB DNS, CloudFront URL).
* `.gitignore` - Terraform state and credential exclusion rules.

## 🚀 How to Run

1. **Prerequisites:** Ensure you have the [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) and [AWS CLI](https://aws.amazon.com/cli/) installed and configured with appropriate IAM credentials.
2. **Initialize Terraform:**
   ```bash
   terraform init

   <img width="1627" height="562" alt="Diagrama sem nome drawio (3)" src="https://github.com/user-attachments/assets/a3759aaf-0796-41ba-bb54-ed02b4884aed" />
