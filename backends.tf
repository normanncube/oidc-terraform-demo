terraform {
  backend "s3" {
    bucket         = "samakoni-terraform-state-bucket"
    key            = "environments/dev/terraform.tfstate"
    region         = "eu-west-1"
    lock           = true # Optional: Enable state locking
    encrypt        = true # Optional: Enable server-side encryption for the state file
  }
}