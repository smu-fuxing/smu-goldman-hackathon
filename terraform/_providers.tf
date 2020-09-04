terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  version = "~> 3.2"
  region  = "us-west-2"
  profile = "smu-fuxing"
}
