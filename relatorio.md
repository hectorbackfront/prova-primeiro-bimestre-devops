# Relatório — Prova do Primeiro Bimestre (DevOps)

**Aluno:** Hector Marcelo Pedroso Dos Santos
**RA:** 6125136
**Ferramenta de IA utilizada:** Claude (via Claude Code)

### Questão 1 — A Jornada Completa (Aulas 01 a 07)

Basicamente eu aprendi sim com o conteúdo das aulas, então alguns conceitos
foram fáceis de implementar nessa prova, e também peguei o conceito de cada
conteúdo que foi passado de aula em aula, e passei em prompts para a IA
seguir esses conceitos. Começamos criando um repositório e definindo o
`.gitignore`, seguindo o Conventional Commits em cada etapa como pedido,
conforme foi revisado nas primeiras aulas. Também continuamos com a parte
do Docker, já criando a pasta `app/` com a API Node.js/Express+PostgreSQL,
assim fazendo o arquivo Dockerfile multi-stage com usuário não-root +
`.dockerignore`, tudo sendo testado com a IA que fiz e também via terminal
por descargo de consciência usando os comandos (`docker build`,
`docker run`). Baseando em etapa da prova, também segui com os conceitos
revisados e passados para minha IA aplicando o `docker-compose.yml` numa
feature branch (`feat/docker-compose`) com merge na `main`, fazendo a
primeira evidência de workflow Git com branch.
Antes de qualquer recurso da AWS, com a IA eu guiei para fazer os módulos
já estruturados (`vpc`, `security-group`, `rds`, `ec2`) — Aula 06 aplicada
desde o início —, em uma branch `feat/terraform-infra`, validado com
`terraform validate` sem credenciais. Aí entrou também a adaptação do
Learner Lab: sem IAM próprio, só `LabInstanceProfile`. Seguindo os
conceitos da Aula 05, apliquei o `terraform apply` criando o bucket S3
versionado e criptografado, mais a tabela DynamoDB, antes de ativar o
backend remoto no projeto principal.
Depois disso, rodei o `terraform apply` do projeto principal, que criou os
recursos na ordem de dependência: primeiro a VPC, com duas subnets públicas
e duas privadas em duas AZs, a EC2 na pública e o RDS na privada — só o
Security Group da EC2 conversa com ele na porta 5432. Depois o RDS
PostgreSQL subiu dentro dessa rede privada, e só por último a EC2, porque
vi que ela precisa do endereço do banco para já subir a API conectada.
Depois de validar tudo funcionando, rodei o `terraform destroy` pra não
ficar consumindo os créditos do Learner Lab à toa.

### Questão 2 — O Processo com IA como Copiloto

_(pendente)_

### Questão 3 — Infraestrutura, Segurança e o Learner Lab

_(pendente)_

### Questão 4 — Validação e Responsabilidade

_(pendente)_
