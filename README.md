# Prova Primeiro Bimestre — DevOps

**Aluno:** Hector Marcelo Pedroso dos Santos
**RA:** 6125136

## Descrição

API de Reservas (Node.js + Express + PostgreSQL), containerizada com Docker e
Docker Compose, e implantada na AWS via Terraform modularizado (VPC,
Security Groups, EC2, RDS), com remote state em S3 + DynamoDB.

## Estrutura planejada

- `app/` — API Node.js/Express com CRUD de reservas
- `infra/` — Terraform (modules: vpc, security-group, ec2, rds)
- `evidencias/` — screenshots e outputs das fases
- `docs/` — devspec, prompts de IA usados e template de entrega
- `relatorio.md` — relatório final (4 questões)

## Como rodar localmente

_(preencher nas fases seguintes: `npm start`, `docker build`, `docker compose up`)_
