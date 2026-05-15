resource "aws_security_group" "sg_final" {
  name        = "sg_evaluacion"
  # ... (mismo contenido de SSH, 80, 8080, 8081 del paso anterior)
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e2c8ccd4e1ffc351" 
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_final.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              # Instalar Docker Compose v2
              mkdir -p /usr/local/lib/docker/cli-plugins/
              curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
              chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
              EOF

  tags = { Name = "Instancia-EP2-DevOps" }
}

output "url_publica" {
  value = "http://${aws_instance.app_server.public_dns}"
}