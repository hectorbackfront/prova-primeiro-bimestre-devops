#!/bin/bash
set -e

# Instala Docker (Amazon Linux 2023)
dnf update -y
dnf install -y docker git
systemctl enable docker
systemctl start docker

# Clona o repositório com o código da API e builda a imagem
git clone ${repo_url} /opt/app
cd /opt/app/app
docker build -t reservas-api .

# Sobe a API conectada ao RDS
docker run -d \
  --name reservas-api \
  --restart unless-stopped \
  -p 3000:3000 \
  -e PORT=3000 \
  -e DB_HOST=${db_host} \
  -e DB_PORT=${db_port} \
  -e DB_USER=${db_user} \
  -e DB_PASS=${db_password} \
  -e DB_NAME=${db_name} \
  -e DB_SSL=true \
  reservas-api
