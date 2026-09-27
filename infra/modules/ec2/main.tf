data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.instance_profile_name

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    repo_url    = var.repo_url
    db_host     = var.db_host
    db_port     = var.db_port
    db_user     = var.db_user
    db_password = var.db_password
    db_name     = var.db_name
  })

  tags = merge(var.tags, {
    Name = "${var.name}-api-ec2"
  })
}
