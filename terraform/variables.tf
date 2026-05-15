variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Nombre de la llave SSH en AWS Academy"
  type        = string
  default     = "vockey" 
}