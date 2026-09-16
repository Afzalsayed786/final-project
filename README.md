# Day 29 - Build CI/CD Project

## Project Overview

This project demonstrates a basic DevOps CI/CD workflow using:

- Flask
- Docker
- Terraform
- AWS EC2
- Ansible
- GitHub Actions
- Docker Hub
- Jenkins

## Project Flow

GitHub → GitHub Actions → Docker Build → Docker Hub → AWS EC2

## Project Structure

```text
final-project/
├── app/
│   ├── app.py
│   └── Dockerfile
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── ansible/
│   ├── inventory.ini
│   └── install_docker.yml
├── .github/
│   └── workflows/
│       └── ci.yml
├── Jenkinsfile
└── README.md
