terraform {
  backend "s3" {
    bucket = "terraform-fsl-backend-78581457"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
