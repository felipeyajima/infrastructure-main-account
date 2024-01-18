terraform {

  cloud {
    organization = "organization-name"

    workspaces {
      name = "infrastructure-main-account"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1"
    }
  }

  required_version = ">= 1.1.0"
}
