# Bootstrap do Remote State

Cria o bucket S3 (versionado + criptografado) e a tabela DynamoDB (locking)
usados pelo backend `s3` do projeto principal (`infra/`).

## Como usar

1. Entre nesta pasta e rode com um nome de bucket único:
   ```
   cd infra/backend
   terraform init
   terraform apply -var="bucket_name=tfstate-reservas-SEU-RA"
   ```
2. Copie os outputs (`bucket_name`, `dynamodb_table_name`).
3. Preencha o bloco `backend "s3"` em `infra/providers.tf` com esses valores
   e descomente o bloco.
4. Na pasta `infra/`, rode `terraform init -migrate-state` para passar a
   usar o state remoto.

Este módulo usa state **local** de propósito — ele cria a própria infra de
state remoto, então não pode depender dela.
