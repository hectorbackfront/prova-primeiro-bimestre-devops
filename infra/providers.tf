terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state: preencher com o bucket/tabela criados em infra/backend/
  # (ver infra/backend/README.md). Deixe comentado até o backend existir,
  # depois rode `terraform init -migrate-state`.
  # backend "s3" {
  #   bucket         = "PREENCHER-nome-do-bucket"
  #   key            = "prova-primeiro-bimestre-devops/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region
}
