terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.55"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    tls = {
      source = "hashicorp/tls"
       version = "3.3.0"
       }
  }
}

provider "aws" {
  region  = "us-east-1" #The region where the environment 
}