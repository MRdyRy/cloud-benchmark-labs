variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Region AWS untuk Floci"
}

variable "aws_access_key" {
  type        = string
  description = "AWS Access Key untuk Floci"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key untuk Floci"
  sensitive   = true
}