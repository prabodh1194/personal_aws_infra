terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>5.19.0"
        }
    }

    required_version = ">1.2"
}

provider "aws" {
    region = "us-east-1"
}
