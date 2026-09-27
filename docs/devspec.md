# DevSpec — Prova DevOps 1º Bimestre

## Objetivo
Entregar API de Reservas (Node.js + PostgreSQL) do Git até infraestrutura AWS modularizada com Terraform.

## Fases (Ordem Obrigatória)

### FASE 1: Setup Inicial (Git + README)
- [ ] Criar repo `prova-primeiro-bimestre-devops`
- [ ] Clonar localmente
- [ ] Criar README.md (nome, RA, descrição)
- [ ] Criar .gitignore (node_modules, .env, .terraform, *.tfstate, *.pem)
- [ ] Primeiro commit: `chore: initial commit`

### FASE 2: Aplicação API (Node.js)
- [ ] Pasta `app/` com package.json
- [ ] src/index.js com Express + CRUD de reservas (POST, GET, GET/:id, PUT, DELETE, /health)
- [ ] Conexão com PostgreSQL (variáveis de env)
- [ ] Testar local com `npm start`
- [ ] Commit: `feat: add reservas API with CRUD`

### FASE 3: Docker
- [ ] Dockerfile da API (multi-stage, usuário não-root)
- [ ] .dockerignore
- [ ] Build: `docker build -t reservas-api .`
- [ ] Run test: `docker run -p 3000:3000 reservas-api`
- [ ] Commit: `feat: add Dockerfile`

### FASE 4: Docker Compose (Local)
- [ ] docker-compose.yml (API + PostgreSQL)
- [ ] Volume nomeado para DB
- [ ] .env.example (sem senhas)
- [ ] Test: `docker compose up` → API em 3000, DB em 5432
- [ ] Commit: `feat: add docker-compose for local env`

### FASE 5: Terraform (Infra AWS)
- [ ] Pasta `infra/` com modules (vpc, security-group, ec2, rds)
- [ ] main.tf (composição dos modules)
- [ ] providers.tf (AWS + backend S3)
- [ ] Backend S3 + DynamoDB criado
- [ ] terraform validate, terraform plan
- [ ] terraform apply (no Lab com LabRole)
- [ ] Commit: `feat: add terraform infra`

### FASE 6: Evidências
- [ ] Screenshots/outputs em pasta `evidencias/`
- [ ] docker compose ps
- [ ] terraform plan
- [ ] Commits no histórico

### FASE 7: Relatório
- [ ] relatorio.md com 4 questões respondidas
- [ ] Commit: `docs: add report`

### FASE 8: Entrega
- [ ] terraform destroy
- [ ] Fork + PR no repo da disciplina
- [ ] arquivo `entrega.md` em `entregas/provaPrimeiroBi/RA/`

---

## Checkpoints (Validar Antes de Passar)

| Fase | Checkpoint |
|------|-----------|
| 1 | `git log --oneline` mostra commits |
| 2 | `npm start` sobe API, testa CRUD com curl |
| 3 | `docker run` executa sem erro |
| 4 | `docker compose up` → API + DB em 10s |
| 5 | `terraform plan` sem erro, RDS em subnet privada |
| 6 | Screenshots salvos |
| 7 | relatório.md tem 10+ linhas por questão |
| 8 | PR aberto no dia da prova |

---

## Prompts IA (Ver `.hernes-prompts.md`)
