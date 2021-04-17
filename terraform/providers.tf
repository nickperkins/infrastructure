terraform {
  backend "s3" {
    bucket = "nperkins-terraform-state"
    key    = "infrastructure"
    region = "ap-southeast-2"
  }

  required_providers {
    
    aws = {
      source = "hashicorp/aws"
      version = ">=3.37.0"
    }
  }
}

# Default provider
provider "aws" {
  region = "ap-southeast-2" 
}
