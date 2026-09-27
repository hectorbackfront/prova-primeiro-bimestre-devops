# Hernes — Prompts Prontos pra IA

Use esses prompts com Claude, ChatGPT, etc. Copie → Adapte → Valide.

---

## PROMPT 1: Estrutura do Projeto Node.js + Express + PostgreSQL

**Copie e cole isso:**

```
Preciso de uma API Node.js/Express com CRUD de reservas que salva em PostgreSQL.

Requisitos:
- Rotas: POST /reservas, GET /reservas, GET /reservas/:id, PUT /reservas/:id, DELETE /reservas/:id, GET /health
- Campos da reserva: id, cliente, data, status
- Conexão com DB via variáveis de env: DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT
- Validação básica (campos obrigatórios)
- Responder JSON com status HTTP correto (201 create, 200 ok, 404 not found, etc)

Gera:
1. package.json com dependências (express, pg)
2. src/index.js com todas as rotas
3. .env.example
4. Instruções de teste

Contexto: É pra uma prova de DevOps, vou usar Docker e Terraform depois.
```

**Depois:** Copia a resposta → cria pasta `app/`, `package.json`, `src/index.js` → `npm install` → testa local.

---

## PROMPT 2: Dockerfile Multi-Stage

**Copie e cole:**

```
Gera um Dockerfile multi-stage pra essa API Node.js/Express:
- Stage 1: Builder (npm install)
- Stage 2: Runtime (usuário não-root, alpine recomendado)
- Expo porta 3000
- Health check: GET /health
- .dockerignore também

Requisitos:
- Não rodar como root
- NODE_ENV=production no runtime
- EXPOSE 3000
- CMD com node
```

**Depois:** Copia → `app/Dockerfile` → `docker build -t reservas-api .` → testa.

---

## PROMPT 3: Docker Compose (API + PostgreSQL)

**Copie e cole:**

```
Gera docker-compose.yml pra subir:
- Serviço API (imagem da prova-primeiro-bimestre-devops, porta 3000)
- Serviço PostgreSQL (imagem postgres:15-alpine, porta 5432)
- Volume nomeado pra persistência do DB
- Rede bridge customizada
- Healthcheck no PostgreSQL
- depends_on com condição de healthcheck
- Variáveis de env (DB_HOST=postgres, etc)

Requisitos:
- .env.example versionado (sem senhas)
- .env no .gitignore
- `docker compose up` sobe tudo em um comando
- PostgreSQL é chamado 'postgres' internamente
```

**Depois:** Copia → cria `docker-compose.yml` + `.env.example` → `docker compose up` → testa.

---

## PROMPT 4: Terraform Modules (VPC, SG, EC2, RDS)

**Copie e cole:**

```
Gera Terraform modularizado pra AWS Academy Learner Lab:

Estrutura:
- modules/vpc/ → VPC com 2 subnets públicas + 2 privadas (2 AZs, us-east-1)
- modules/security-group/ → SG pra EC2 (22, 3000) + SG pra RDS (5432 apenas do EC2 SG)
- modules/ec2/ → EC2 t2.micro na subnet pública, instance profile LabInstanceProfile
- modules/rds/ → PostgreSQL db.t3.micro nas subnets privadas, publicly_accessible=false, storage_encrypted=true

Requisitos:
- Usar LabRole / LabInstanceProfile (NÃO criar IAM próprio)
- Region us-east-1
- Outputs úteis: IP da EC2, endpoint RDS, URL da API
- Tags em todos os recursos
- Sem hardcode (variáveis)

main.tf compõe os modules. Gera também variables.tf, outputs.tf, providers.tf.

Contexto: AWS Academy Learner Lab, credenciais temporárias via CLI, precisa de remote state depois.
```

**Depois:** Copia → `infra/` → valida com `terraform validate` → planeja com `terraform plan`.

---

## PROMPT 5: Remote State (S3 + DynamoDB)

**Copie e cole:**

```
Gera os configs de Remote State pra Terraform:

1. Script/código pra criar:
   - S3 bucket (versionamento ON, encriptação ON, não public)
   - DynamoDB table pra locking (1 RCU/WCU)

2. Backend config pra terraform (backend "s3" no providers.tf):
   - bucket = "seu-bucket"
   - key = "terraform.tfstate"
   - region = "us-east-1"
   - dynamodb_table = "terraform-lock"
   - encrypt = true

Contexto: AWS Academy Learner Lab, precisa ser criado manualmente com credenciais antes de usar no projeto.
```

**Depois:** Executa script → pega nomes do bucket/table → configura no `providers.tf`.

---

## PROMPT 6: Relatório (4 Questões)

**Copie e cole (DEPOIS de tudo pronto):**

```
Preciso responder 4 questões de um relatório dissertativo (10+ linhas cada):

1. A Jornada Completa: Como conectei Git → Docker → Docker Compose → Terraform + Modules?
2. Processo com IA: Qual ferramenta usei? Que prompts? O que a IA fez bem/mal?
3. Infraestrutura AWS: Por que RDS em subnet privada? Como usei LabRole?
4. Validação e Responsabilidade: Que checklist fiz antes de terraform apply?

Gera template estruturado que eu preencho com minha experiência real.

Contexto: Prova de DevOps, usei [Kiro / Claude / ChatGPT / etc].
```

**Depois:** Preenche com sua experiência real → salva em `relatorio.md`.

---

## Como Usar (Workflow)

1. Copia um prompt acima
2. Cola no Claude / ChatGPT / Kiro
3. **Valida a resposta** (código, sintaxe, lógica)
4. Adapta se precisar (nomes, variáveis)
5. Aplica no projeto
6. **Testa local** antes de subir

---

## Dicas

- NÃO aceita tudo que a IA gera — **lê e valida**
- Se der erro, manda o erro pra IA com contexto
- Commit depois de cada fase (rastreamento Git)
- Terraform: valida antes de apply (`terraform validate`, `terraform plan`)
