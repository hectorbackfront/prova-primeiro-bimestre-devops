const express = require('express');
const { pool, initDb } = require('./db');

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

app.post('/reservas', async (req, res) => {
  const { cliente, data, status } = req.body;
  if (!cliente || !data) {
    return res.status(400).json({ error: 'Campos obrigatórios: cliente, data' });
  }
  try {
    const result = await pool.query(
      'INSERT INTO reservas (cliente, data, status) VALUES ($1, $2, $3) RETURNING *',
      [cliente, data, status || 'pendente']
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao criar reserva' });
  }
});

app.get('/reservas', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM reservas ORDER BY id');
    res.status(200).json(result.rows);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao listar reservas' });
  }
});

app.get('/reservas/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM reservas WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reserva não encontrada' });
    }
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao buscar reserva' });
  }
});

app.put('/reservas/:id', async (req, res) => {
  const { cliente, data, status } = req.body;
  if (!cliente || !data) {
    return res.status(400).json({ error: 'Campos obrigatórios: cliente, data' });
  }
  try {
    const result = await pool.query(
      'UPDATE reservas SET cliente = $1, data = $2, status = $3 WHERE id = $4 RETURNING *',
      [cliente, data, status || 'pendente', req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reserva não encontrada' });
    }
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao atualizar reserva' });
  }
});

app.delete('/reservas/:id', async (req, res) => {
  try {
    const result = await pool.query('DELETE FROM reservas WHERE id = $1 RETURNING *', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reserva não encontrada' });
    }
    res.status(200).json({ message: 'Reserva removida' });
  } catch (err) {
    res.status(500).json({ error: 'Erro ao remover reserva' });
  }
});

initDb()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`API rodando na porta ${PORT}`);
    });
  })
  .catch((err) => {
    console.error('Erro ao conectar no banco:', err);
    process.exit(1);
  });
