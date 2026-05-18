terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del Proveedor usando variables
provider "aws" {
  region = var.aws_region
}

# SOLUCIÓN PRO: Filtro dinámico para obtener la última AMI válida de Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Grupo de Seguridad corregido
resource "aws_security_group" "sg_final" {
  name        = "sg_evaluacion_v2"
  description = "Grupo de seguridad para la aplicacion en Docker"

  # Acceso SSH para administración e integración con GitHub Actions
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # En producción se recomienda restringir a IPs conocidas
  }

  # Acceso al Frontend de la aplicación (Puerto mapeado en tu docker-compose)
  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida libre a internet para que la máquina descargue Docker y las imágenes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_evaluacion"
  }
}

# Instancia EC2
resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux.id # Usa el ID dinámico y corregido
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_final.id]

  # Script automatizado para instalar Docker y Docker Compose v2 al arrancar
  user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install -y docker
    service docker start
    usermod -a -G docker ec2-user
    
    # Instalar Docker Compose v2 como plugin CLI global
    mkdir -p /usr/local/lib/docker/cli-plugins/
    curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
  EOT

  tags = {
    Name = "Instancia-EP2-DevOps"
  }
}

# Output para ver la URL/IP pública apenas termine el terraform apply
output "url_publica" {
  description = "IP pública de la instancia creada"
  value       = "http://${aws_instance.app_server.public_ip}:8082"
}