# Prompts Usados — Registro Real

Registro dos prompts efetivamente usados durante o desenvolvimento (com Claude),
para preencher a Questão 2 do relatório final. Diferente do `hernes-prompts.md`
(que é o modelo pronto), este arquivo é o log real: o que foi pedido, quando,
e o que a IA gerou/fez de errado.

---

## Prompt 1 — Estrutura do Projeto Node.js + Express + PostgreSQL

**Fase:** 2 (Aplicação API)
**Ferramenta:** Claude (Sonnet 5, via Claude Code)

**Prompt usado:**
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

**Resultado:** Gerado `app/` com `package.json` (express + pg), `src/db.js` (pool de
conexão + criação automática da tabela `reservas` no start), `src/index.js`
(rotas CRUD completas), `.env.example` e `app/README.md` com instruções de
teste. Validado localmente: subi um PostgreSQL descartável via Docker
(`postgres:15-alpine`, porta 5433) só para teste, rodei `npm start` e testei
todas as rotas com `curl` — POST (201), GET lista (200), GET por id (200),
PUT (200), DELETE (200), GET após delete (404) e POST sem campo obrigatório
(400). Tudo funcionou sem ajustes manuais no código gerado. Container de
teste removido depois (`docker rm -f`) — não faz parte do projeto, só serviu
pra validar a Fase 2 antes do Docker Compose oficial (Fase 4).

---

<!-- Próximos prompts entram abaixo, na ordem em que forem usados -->
