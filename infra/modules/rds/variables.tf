variable "name" {
  description = "Prefixo de nome usado nas tags e identificador do RDS"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas (2 AZs) para o DB Subnet Group"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID do Security Group do RDS (acesso apenas da EC2)"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuário master do banco"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha master do banco (sensível, sem default)"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "engine_version" {
  description = "Versão do PostgreSQL"
  type        = string
  default     = "15"
}

variable "tags" {
  description = "Tags comuns aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}
