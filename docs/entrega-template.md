# Entrega — Prova do Primeiro Bimestre (DevOps)

**Aluno:** Hector Marcelo Pedroso dos Santos
**RA:** 6125136
**Data:** [Data da prova — preenche no dia]
**Ferramenta de IA utilizada:** [Claude / ChatGPT / Kiro / Copilot / outra]

---

## Repositório do Projeto

- **URL:** https://github.com/hectorbackfront/prova-primeiro-bimestre-devops

---

## Checklist de Evidências

- [ ] Repositório público no GitHub (`prova-primeiro-bimestre-devops`)
- [ ] README.md com nome, RA e descrição do projeto
- [ ] .gitignore adequado (node_modules, .env, .terraform, *.tfstate, *.pem)
- [ ] Mínimo 6 commits com Conventional Commits (`feat:`, `docs:`, `fix:`, `chore:`)
- [ ] Feature branch + merge (evidência de workflow Git)
- [ ] API Node.js/Express com **CRUD completo** de reservas
  - [ ] POST /reservas (Create)
  - [ ] GET /reservas (Read List)
  - [ ] GET /reservas/:id (Read One)
  - [ ] PUT /reservas/:id (Update)
  - [ ] DELETE /reservas/:id (Delete)
  - [ ] GET /health (Health Check)
- [ ] Rotas de CRUD gravando no **banco PostgreSQL** (não em memória)
- [ ] Dockerfile funcional (multi-stage, usuário não-root)
- [ ] .dockerignore configurado
- [ ] docker-compose.yml (API + PostgreSQL) subindo com um comando
- [ ] Volume nomeado para persistência do banco
- [ ] Rede bridge customizada no Compose
- [ ] Healthcheck no PostgreSQL
- [ ] .env.example versionado (sem senhas reais)
- [ ] .env no .gitignore
- [ ] Terraform modularizado
  - [ ] Módulo VPC (2 subnets públicas + 2 privadas, 2 AZs)
  - [ ] Módulo Security Groups (EC2 e RDS com menor privilégio)
  - [ ] Módulo EC2 (t2.micro, subnet pública, instance profile LabInstanceProfile)
  - [ ] Módulo RDS (PostgreSQL db.t3.micro, subnets privadas, storage_encrypted=true, publicly_accessible=false)
- [ ] Remote State configurado (S3 + DynamoDB)
- [ ] main.tf com composição dos modules
- [ ] variables.tf, outputs.tf, providers.tf configurados
- [ ] terraform validate sem erros
- [ ] terraform plan executado com sucesso
- [ ] terraform apply executado no AWS Academy Learner Lab
- [ ] Uso de LabRole/LabInstanceProfile (sem criar IAM próprio)
- [ ] Evidências capturadas (outputs/screenshots)
  - [ ] docker compose ps
  - [ ] terraform plan output
  - [ ] EC2 rodando com API
  - [ ] RDS endpoint funcional
- [ ] relatorio.md completo (4 questões, 10+ linhas cada)
- [ ] terraform destroy executado (limpeza)
- [ ] Todos os commits com histórico Git limpo

---

## Evidências (Cole aqui)

### Docker Build
```
[Cole output de docker build]
```

### Docker Compose
```
[Cole output de docker compose ps]
```

### Terraform Plan
```
[Cole output de terraform plan]
```

### Terraform Apply
```
[Cole output relevante de terraform apply]
```

### Screenshots (opcional)
- [ ] API rodando no localhost (curl /reservas)
- [ ] EC2 rodando na AWS (IP público)
- [ ] RDS endpoint visível

---

## Links Úteis

- Repositório do projeto: https://github.com/hectorbackfront/prova-primeiro-bimestre-devops
- Commits: [Link pro histórico]
- Relatório completo: [Link pro relatorio.md]

---

## Notas

- Prova entregue via Pull Request no repositório da disciplina
- Pasta: `entregas/provaPrimeiroBi/6125136/`
- Arquivo: `entrega.md` (este)
- Data de abertura do PR: Dia da prova (presencialmente)

**Status:** ✅ Pronto para entrega
