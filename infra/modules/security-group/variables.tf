variable "name" {
  description = "Prefixo de nome usado nas tags e nomes dos Security Groups"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde os Security Groups serão criados"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR permitido para acesso SSH (22) à EC2"
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Tags comuns aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}
