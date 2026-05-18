variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre de la llave SSH para acceder a la instancia"
  type        = string
  default     = "vockey" # Llave por defecto en laboratorios AWS Academy
}