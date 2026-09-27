variable "aws_region" {
  description = "Região AWS (Learner Lab exige us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado como prefixo de tags e recursos"
  type        = string
  default     = "reservas"
}

variable "azs" {
  description = "2 Availability Zones usadas pela VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "repo_url" {
  description = "URL do repositório Git público com o código da API (clonado pela EC2)"
  type        = string
  default     = "https://github.com/hectorbackfront/prova-primeiro-bimestre-devops.git"
}

variable "db_name" {
  description = "Nome do banco de dados PostgreSQL"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuário master do banco"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha master do banco. Definir via terraform.tfvars (não versionado) ou -var na linha de comando."
  type        = string
  sensitive   = true
}
