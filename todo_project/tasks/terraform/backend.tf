
terraform {
    backend "s3" {
        bucket = "statefile-wali-bucket"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}
