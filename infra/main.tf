terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_IUOHYHuoh"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_IUOHYHuoh/1e68c4ld54ikkdo5rj3jl9e802"
}