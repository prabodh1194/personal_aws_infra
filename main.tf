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

module "ray_geenral_purpose_compute" {
    source = "./ray_general_purpose_compute"
}
