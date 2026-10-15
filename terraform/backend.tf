# Configure Amazon S3 as the remote backend for Terraform state.
terraform {
  backend "s3" {
    # Dedicated bucket created for this project.
    bucket = "final-project-terraform-state-295028317770"

    # Keep this project's state separate from other projects.
    key = "final-project/terraform.tfstate"

    # Region where the S3 bucket exists.
    region = "eu-north-1"

    # Encrypt the state stored in S3.
    encrypt = true

    # Use S3-native state locking to prevent concurrent state changes.
    use_lockfile = true
  }
}
