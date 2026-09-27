# Reservas API

API Node.js/Express com CRUD de reservas, persistindo em PostgreSQL.

## Rotas

| Método | Rota            | Descrição              |
|--------|-----------------|-------------------------|
| GET    | /health         | Health check            |
| POST   | /reservas       | Cria reserva             |
| GET    | /reservas       | Lista reservas           |
| GET    | /reservas/:id   | Busca reserva por id     |
| PUT    | /reservas/:id   | Atualiza reserva         |
| DELETE | /reservas/:id   | Remove reserva           |

Campos da reserva: `cliente` (obrigatório), `data` (obrigatório), `status` (opcional, default `pendente`).

## Como testar localmente

1. Suba um PostgreSQL (local ou container) e crie um banco `reservas`.
2. Copie `.env.example` para `.env` e ajuste `DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME`, `DB_PORT`.
3. Instale as dependências e rode:
   ```
   npm install
   npm start
   ```
4. Teste as rotas com curl:
   ```bash
   curl localhost:3000/health

   curl -X POST localhost:3000/reservas \
     -H "Content-Type: application/json" \
     -d '{"cliente":"Hector","data":"2026-10-01","status":"confirmado"}'

   curl localhost:3000/reservas

   curl localhost:3000/reservas/1

   curl -X PUT localhost:3000/reservas/1 \
     -H "Content-Type: application/json" \
     -d '{"cliente":"Hector Santos","data":"2026-10-02","status":"cancelado"}'

   curl -X DELETE localhost:3000/reservas/1
   ```

A tabela `reservas` é criada automaticamente no start, se não existir.
