output "dynamodb_table_name" {
  value       = aws_dynamodb_table.users_table.name
  description = "Nama tabel DynamoDB yang berhasil dibuat di Floci"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.metrics_bucket.bucket
  description = "Nama S3 Bucket yang berhasil dibuat di Floci"
}

output "floci_endpoint_used" {
  value       = "http://localhost:4566"
  description = "Endpoint emulator lokal Floci yang ditargetkan"
}