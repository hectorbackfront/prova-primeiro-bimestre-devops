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

## Prompt 2 — Dockerfile Multi-Stage

**Fase:** 3 (Docker)
**Ferramenta:** Claude (Sonnet 5, via Claude Code)

**Prompt usado:**
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

**Resultado:** Gerado `app/Dockerfile` (builder `node:20-alpine` faz `npm install
--omit=dev`, runtime `node:20-alpine` cria usuário `appuser` não-root via
`addgroup`/`adduser`, copia só `node_modules` + `src` + `package.json` do
builder) e `app/.dockerignore` (ignora `node_modules`, `.env`, `.git`, etc.).
Validado com Docker real: `docker build -t reservas-api .` completou sem
erro; subi um Postgres descartável + o container da API numa rede Docker
dedicada; `docker exec reservas-api-test whoami` confirmou `appuser` (não
root); `docker inspect` mostrou `Health: healthy`; testei `/health` e
`POST /reservas` dentro do container rodando — ambos OK (200 e 201).
Evidência salva em `evidencias/fase3-docker.txt`. Containers/rede de teste
removidos depois (`docker rm -f`, `docker network rm`) — não fazem parte do
projeto final, só validaram a Fase 3 antes do Docker Compose oficial.

---

## Prompt 3 — Docker Compose (API + PostgreSQL)

**Fase:** Parte 3 do enunciado (Docker Compose)
**Ferramenta:** Claude (Sonnet 5, via Claude Code)

**Prompt usado:**
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

**Resultado:** Gerado `docker-compose.yml` na raiz (serviço `api` faz build de
`./app`, serviço `postgres` com `postgres:15-alpine`, volume nomeado
`reservas-db-data`, rede bridge `reservas-net`, healthcheck via `pg_isready`,
`depends_on: condition: service_healthy`) e `.env.example` na raiz
(`DB_USER`, `DB_PASS`, `DB_NAME`). Ao testar com `docker compose up`, a IA
gerou inicialmente `ports: "5432:5432"` pro Postgres, que **conflitou** com o
PostgreSQL do sistema operacional já rodando na porta 5432 do host — a IA não
tinha como saber disso. Corrigi manualmente pra `"5433:5432"` (só a porta
externa/host muda; internamente, entre os containers, continua 5432, que é o
que o enunciado pede e o que a API usa via `DB_HOST=postgres`). Depois disso,
`docker compose up -d` subiu os dois serviços com um comando só, o Postgres
ficou `healthy` antes da API iniciar (confirmando o `depends_on` condicional),
e testei o CRUD via `curl` (`/health`, `POST /reservas`, `GET /reservas`) —
tudo funcionando com os dados persistidos no Postgres do Compose. Evidência
salva em `evidencias/compose-ps.txt`. Ambiente de teste derrubado depois com
`docker compose down`.

---

<!-- Próximos prompts entram abaixo, na ordem em que forem usados -->
