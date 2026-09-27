variable "name" {
  description = "Prefixo de nome usado nas tags e na instância EC2"
  type        = string
}

variable "public_subnet_id" {
  description = "ID da subnet pública onde a EC2 será criada"
  type        = string
}

variable "security_group_id" {
  description = "ID do Security Group da EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_profile_name" {
  description = "Nome do instance profile já existente no Learner Lab (LabInstanceProfile)"
  type        = string
  default     = "LabInstanceProfile"
}

variable "repo_url" {
  description = "URL do repositório Git público com o código da API"
  type        = string
}

variable "db_host" {
  description = "Host do RDS (endpoint sem a porta)"
  type        = string
}

variable "db_port" {
  description = "Porta do RDS"
  type        = number
  default     = 5432
}

variable "db_user" {
  description = "Usuário do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do banco (sensível)"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nome do banco"
  type        = string
}

variable "tags" {
  description = "Tags comuns aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}
