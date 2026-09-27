output "endpoint" {
  description = "Endpoint de conexão do RDS (host:porta)"
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "Host do RDS (sem porta)"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Porta do RDS"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.this.db_name
}
