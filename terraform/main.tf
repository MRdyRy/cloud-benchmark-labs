terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Membelokkan traffic Terraform ke emulator Floci lokal
  endpoints {
    dynamodb = "http://localhost:4566"
    s3       = "http://localhost:4566"
  }
}

# Resource 1: DynamoDB Table untuk Benchmark menyimpan data User
resource "aws_dynamodb_table" "users_table" {
  name           = "BenchmarkUsers"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# Resource 2: S3 Bucket untuk Benchmark menyimpan file/payload
resource "aws_s3_bucket" "metrics_bucket" {
  bucket        = "cloud-benchmark-metrics-bucket"
  force_destroy = true
}