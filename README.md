# DevOps EVA02

Proyecto académico DevOps basado en arquitectura Fullstack con automatización CI/CD utilizando GitHub Actions, Docker y AWS EC2.

---

# Tecnologías utilizadas

* Frontend: HTML / CSS / JavaScript
* Backend: Spring Boot
* Base de datos: MySQL
* Contenedores: Docker & Docker Compose
* CI/CD: GitHub Actions
* Cloud: AWS EC2
* Infraestructura: Terraform

---

# Arquitectura del Proyecto

Frontend → Backend Spring Boot → MySQL

Pipeline CI/CD:

GitHub → GitHub Actions → Docker Hub → AWS EC2

---

# Prerrequisitos

* Docker
* Docker Compose
* Java 17
* Maven
* Node.js
* AWS CLI
* Terraform

---

# Ejecución local

## Clonar repositorio

```bash
git clone URL_DEL_REPOSITORIO
cd DevOps-eva02
```

## Levantar contenedores

```bash
docker compose up --build
```

---

# Acceso local

| Servicio          | URL                   |
| ----------------- | --------------------- |
| Frontend          | http://localhost:8082 |
| Backend Ventas    | http://localhost:8080 |
| Backend Despachos | http://localhost:8081 |
| MySQL             | localhost:3307        |

---

# Pipeline CI/CD

El pipeline automatizado realiza:

1. Build del frontend
2. Build backend Spring Boot
3. Construcción imágenes Docker
4. Push imágenes Docker Hub
5. Conexión SSH a AWS EC2
6. Actualización automática de contenedores

---Pasos a seguir para correr pipeline

1. Encender laboratorio aws
2. Extraer de ahi las credenciales y pegarlas en la terminal repositorio /terraform
3. aws configure en la terminal Git bash, y pegar las creadenciales del aws
4. Ejecutar los siguientes comandos: /terraform Init /terraform Plan /Terraform apply
5. ssh -i {ruta pem} ec2-user@{ipPublica}
6. sudo systemctl start docker
7. Actualizar los secretos de github (ssh key, DireccionIP_AWS)
8. Intentar correr el pipeline en Actions
9. Esperar checkList

---

# Infraestructura AWS

La infraestructura cloud fue desplegada mediante Terraform utilizando:

* VPC personalizada
* Subred pública para frontend
* Subred privada para backend
* Security Groups
* Instancias EC2

---

# Integrantes

* Oscar Silva
* Wiliam Caceres
* Israel Bordones

