# Relatório — Prova do Primeiro Bimestre (DevOps)

**Aluno:** Hector Marcelo Pedroso Dos Santos
**RA:** 6125136
**Ferramenta de IA utilizada:** Claude (via Claude Code)

### Questão 1 — A Jornada Completa (Aulas 01 a 07)

Basicamente eu aprendi sim com o conteúdo das aulas, então alguns conceitos
foram fáceis de implementar nessa prova, e também peguei o conceito de cada
conteúdo que foi passado de aula em aula, e passei em prompts para a IA
seguir esses conceitos. Começamos criando um repositório e definindo o
.gitignore, seguindo o Conventional Commits em cada etapa como pedido,
conforme foi revisado nas primeiras aulas. Também continuamos com a parte
do Docker, já criando a pasta app/ com a API Node.js/Express+PostgreSQL,
assim fazendo o arquivo Dockerfile multi-stage com usuário não-root +
.dockerignore, tudo sendo testado com a IA que fiz e também via terminal
por descargo de consciência usando os comandos (docker build,
docker run). Baseando em etapa da prova, também segui com os conceitos
revisados e passados para minha IA aplicando o docker-compose.yml numa
feature branch (feat/docker-compose) com merge na main, fazendo a
primeira evidência de workflow Git com branch.
Antes de qualquer recurso da AWS, com a IA eu guiei para fazer os módulos
já estruturados (vpc, security-group, rds, ec2) — Aula 06 aplicada
desde o início —, em uma branch feat/terraform-infra, validado com
terraform validate sem credenciais. Aí entrou também a adaptação do
Learner Lab: sem IAM próprio, só LabInstanceProfile. Seguindo os
conceitos da Aula 05, apliquei o terraform apply criando o bucket S3
versionado e criptografado, mais a tabela DynamoDB, antes de ativar o
backend remoto no projeto principal.
Depois disso, rodei o terraform apply do projeto principal, que criou os
recursos na ordem de dependência: primeiro a VPC, com duas subnets públicas
e duas privadas em duas AZs, a EC2 na pública e o RDS na privada — só o
Security Group da EC2 conversa com ele na porta 5432. Depois o RDS
PostgreSQL subiu dentro dessa rede privada, e só por último a EC2, porque
vi que ela precisa do endereço do banco para já subir a API conectada.
Depois de validar tudo funcionando, rodei o terraform destroy pra não
ficar consumindo os créditos do Learner Lab à toa.

### Questão 2 — O Processo com IA como Copiloto

Usei o Claude Code, é a ferramenta de IA que uso no meu dia a dia, e já
tinha implementado comportamentos e regras nela pra que ela me seguisse em
outros projetos comigo, me auxiliando e me ajudando a planejar, testar e
executar. Agora, com o pouco de conhecimento que tive de spec-driven e
harness, executei com dois arquivos com esses direcionamentos, dedicados
só pra prova (ficaram em docs/ no projeto). Com isso planejado, comecei
a executar a prova seguindo as etapas.

Usei prompts estruturados em cada etapa pedi a estrutura da API
Node.js/Express+PostgreSQL com os requisitos de rotas e validação, o
Dockerfile multi-stage não-root, o docker-compose.yml com healthcheck e
rede customizada, os módulos Terraform pro Learner Lab e o remote state
S3+DynamoDB — todos registrados com o resultado real em
docs/prompts-usados.md.

A IA me auxiliou bem na maior parte: a API CRUD saiu funcionando de
primeira, o Dockerfile multi-stage também funcionou sem correção, e os
módulos Terraform vieram já compostos corretamente, com o output do RDS
alimentando a EC2. Onde precisei corrigir (detalhe que, pra rastrear o
erro, o Claude foi muito eficiente) o docker-compose.yml veio com a
porta 5432 do Postgres mapeada pro host, que conflitou com o Postgres que
eu já tinha rodando localmente, também o RDS da AWS exige SSL por padrão,
e o código gerado não configurava isso notei que a API ficava em loop
de restart na EC2, e corrigi manualmente com auxílio do Claude,
adicionando SSL.

A IA ajudou sim economizando tempo, gerando a estrutura repetitiva de
rotas CRUD, a sintaxe do Dockerfile e o boilerplate dos módulos Terraform.
Mas me atrapalhou no sentido de não substituir testar de verdade os
dois problemas só apareceram rodando o código, não lendo ele. Isso mostra
que faz sentido a IA pode acelerar a escrita, mas não a validação.

### Questão 3 — Infraestrutura, Segurança e o Learner Lab

**Diagrama da arquitetura:**

```
                                  Internet
                                     │
                            ┌────────▼────────┐
                            │ Internet Gateway │
                            └────────┬────────┘
                                     │
 VPC 10.0.0.0/16 (us-east-1)         │
┌────────────────────────────────────┼─────────────────────────────┐
│                                     │                             │
│  Subnet pública (us-east-1a)       │   Subnet pública (us-east-1b)│
│  10.0.1.0/24                       ▼   10.0.2.0/24                │
│  ┌───────────────────────┐                                       │
│  │ EC2 t2.micro           │  SG-ec2: entrada 22, 3000 (0.0.0.0/0) │
│  │ IP público              │  IAM: LabInstanceProfile             │
│  │ roda a API (Docker)     │                                     │
│  └──────────┬──────────────┘                                     │
│             │ 5432 (somente a partir do SG-ec2)                   │
│             ▼                                                     │
│  Subnet privada (us-east-1a)        Subnet privada (us-east-1b)   │
│  10.0.11.0/24                        10.0.12.0/24                 │
│  ┌───────────────────────┐                                        │
│  │ RDS PostgreSQL          │  SG-rds: entrada 5432 só do SG-ec2    │
│  │ db.t3.micro             │  publicly_accessible = false          │
│  │ sem IP público          │  storage_encrypted = true             │
│  └───────────────────────┘  (DB Subnet Group cobre as 2 AZs)      │
│                                                                    │
└────────────────────────────────────────────────────────────────┘

Remote State (fora da VPC, serviços globais/regionais da conta):
  S3 (bucket versionado + criptografado) + DynamoDB (lock table)
Essa separação do RDS na subnet privada e da EC2 na pública faz sentido
porque o RDS guarda os dados da aplicação cliente, reserva, status,
então não tem motivo pra ele ser alcançável da internet só a própria API
precisa falar com ele, e isso é um princípio de menor privilégio na
prática.

Confesso que não tinha ideia de como aplicar o LabRole/LabInstanceProfile
em vez de criar IAM próprio, então fiz um estudo e descobri que, em vez de
criar uma role nova pra EC2, basta referenciar o LabInstanceProfile que já
existe por padrão na conta — ele já vem com as permissões necessárias pra
esse tipo de lab, sem eu precisar criar nada de IAM.

As credenciais temporárias eu gerei no início da sessão e usei durante
todo o ciclo (apply, testes, destroy), mas entendi, pelas aulas e pelos
TFs, que numa sessão longa espalhada em vários dias eu precisaria gerar
credenciais novas a cada vez que o Lab expirasse. Sobre a região: lembro
do senhor comentar em aula que às vezes o AWS Academy libera só o
us-east-2, mas no meu caso foi liberado mesmo o us-east-1.

Com auxílio da IA eu notei que o Terraform quebrou com um AccessDenied
numa chamada que é algo que não acontece numa conta AWS normal — algo
específico da conta educacional. Precisei rodar
terraform apply -refresh=false pra contornar, já que o recurso já tinha
sido criado de verdade, só a releitura automática do Terraform que
falhava.

### Questão 4 — Validação e Responsabilidade

Antes de rodar o terraform apply, apliquei um checklist: `terraform fmt
-recursive` + `terraform validate` sem precisar de credenciais AWS (antes
de qualquer coisa), ler o terraform plan inteiro (não só o resumo),
conferir que a senha do banco não estava hardcoded no código, e revisar
módulo por módulo o que a IA gerou antes de rodar.

Eu sabia que não ia bastar o apply dar certo, então testei de verdade:
tentei resolver o DNS do RDS de fora da VPC e não resolveu, confirmando o
isolamento; olhei via AWS CLI que o security group só aceita a porta 5432
vindo do security group da EC2; confirmei também que a EC2 estava usando
o LabInstanceProfile; e testei o CRUD completo pelo IP público pra
garantir que os dados realmente gravavam no RDS, não só que a API rodava.

O que escapou e eu aceitei sem revisar de verdade foi o código gerado
para conexão com o banco, que não configurava SSL — e o RDS da AWS exige
SSL por padrão. Se eu tivesse rodado só o apply e não tivesse testado a
API de verdade, ela ficaria em loop de crash silencioso na EC2,
consumindo crédito do Learner Lab sem parar.

Por fim, cada etapa — até em outros projetos maiores meus me ensinou a
mesma disciplina de não confiar sem checar, mesmo com a IA bem conduzida
por um prompt bem elaborado: no Git, nunca dou um commit sem olhar o
git status e git diff antes; no Docker, nunca assumo que o container
funciona sem rodar e olhar os logs; no Terraform, o plan é exatamente
esse mesmo hábito aplicado à infraestrutura, um diff do que vai mudar
antes de acontecer de verdade; e os módulos ajudaram a isolar os
problemas.
