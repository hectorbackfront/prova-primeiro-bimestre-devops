output "bucket_name" {
  description = "Nome do bucket S3 criado para o remote state"
  value       = aws_s3_bucket.tfstate.bucket
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB criada para locking"
  value       = aws_dynamodb_table.lock.name
}
