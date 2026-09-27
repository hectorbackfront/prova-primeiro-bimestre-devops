# SG da EC2: acesso SSH (22) e à API (3000)
resource "aws_security_group" "ec2" {
  name        = "${var.name}-ec2-sg"
  description = "Permite SSH e acesso a API de Reservas na EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "API de Reservas"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-ec2-sg"
  })
}

# SG do RDS: aceita PostgreSQL (5432) apenas do SG da EC2 (menor privilégio)
resource "aws_security_group" "rds" {
  name        = "${var.name}-rds-sg"
  description = "Permite PostgreSQL apenas a partir da EC2 da API"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL a partir da EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-rds-sg"
  })
}
