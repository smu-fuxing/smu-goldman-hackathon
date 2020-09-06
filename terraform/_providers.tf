terraform {
  required_version = ">= 0.13"
}

provider "random" {

}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "smu-fuxing"
}

provider "aws" {
  region  = "us-east-1"
  profile = "smu-fuxing"

  alias = "cloudfront"
}

data "aws_region" "current" {
}
