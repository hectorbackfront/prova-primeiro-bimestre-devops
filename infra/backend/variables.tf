variable "aws_region" {
  description = "Região AWS (Learner Lab exige us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado em tags"
  type        = string
  default     = "reservas"
}

variable "bucket_name" {
  description = "Nome único globalmente do bucket S3 para o remote state (ex: tfstate-reservas-SEU-RA)"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB usada para locking do state"
  type        = string
  default     = "terraform-lock"
}
