# DevOps Final Project — CI/CD Pipeline

## 1. Project Overview

This project demonstrates a DevOps workflow using GitHub Actions, Jenkins, Docker, Terraform, AWS EC2, Amazon ECR, Ansible, and Amazon S3.

The goal is to automate application building and testing, container image publishing, and Terraform infrastructure validation and planning.

## 2. Project Architecture

**Application pipeline:**

GitHub → Jenkins → Docker Build → Application Test → Amazon ECR

**GitHub Actions pipeline:**

GitHub Push / Pull Request → Application CI → Docker Build and Test

**Terraform pipeline:**

GitHub → Terraform Format → Terraform Validate → Terraform Plan → S3 Remote State Backend

The Terraform workflow currently validates and plans infrastructure changes. It does not automatically apply changes to AWS.

## 3. Technologies Used

- **Git and GitHub:** Source code management.
- **GitHub Actions:** Application CI and Terraform checks.
- **Jenkins:** Application build, testing, and image publishing pipeline.
- **Docker:** Builds and runs the application container.
- **Amazon ECR:** Stores Docker images.
- **Terraform:** Defines AWS infrastructure.
- **Amazon S3:** Stores Terraform remote state.
- **Ansible:** Contains configuration automation files.
- **AWS EC2:** Target infrastructure defined in Terraform.

## 4. Project Structure

```text
final-project/
├── app/
│   ├── app.py
│   └── Dockerfile
├── ansible/
│   ├── inventory.ini
│   └── install_docker.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── terraform-ci.yml
├── Dockerfile.jenkins
├── Jenkinsfile
├── .gitignore
└── README.md
```

## 5. Application CI

The GitHub Actions application workflow:

1. Checks out the repository.
2. Builds the Docker image.
3. Starts the application container.
4. Tests the application using HTTP.
5. Removes the test container.

## 6. Jenkins Pipeline

The Jenkins pipeline:

1. Checks out the source code.
2. Builds the Docker image.
3. Runs the application and tests its HTTP response.
4. Authenticates with Amazon ECR.
5. Pushes the image using the `latest` and build-number tags.
6. Removes the test container after the pipeline finishes.

## 7. Terraform CI

The Terraform workflow performs:

1. Formatting checks.
2. Terraform initialization for validation.
3. Configuration validation.
4. Terraform initialization with the configured S3 backend.
5. Terraform planning to preview infrastructure changes.

GitHub Actions uses an AWS IAM role through GitHub OIDC for Terraform plan operations.

**Note:** Terraform apply is not configured in the current workflow.

## 8. Terraform Remote State

Terraform uses an Amazon S3 backend to store its remote state.

The state configuration specifies the S3 bucket, state file key, AWS region, encryption, and state locking.

Local Terraform state files and local variable files are excluded from Git using `.gitignore`.

## 9. Security and Credentials

- AWS credentials for the Jenkins ECR publishing task are stored in Jenkins Credentials.
- GitHub Actions uses OIDC for Terraform access.
- Terraform state files and local variable files are excluded from version control.

## 10. Current Project Status

- GitHub Actions application CI configured.
- GitHub Actions Terraform checks and plan configured.
- Jenkins application build and test pipeline working.
- Amazon ECR image publishing tested successfully.
- Terraform S3 backend configured.
- Infrastructure deployment through Terraform apply is not part of the current automated workflow.
