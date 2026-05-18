# --- ETAPA 1: Compilación (Build) ---
# Usamos Temurin 17 con Maven para compilar de forma moderna
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build

# Definimos el directorio de trabajo
WORKDIR /app

# Copiamos el archivo de configuración de Maven y el código fuente
COPY pom.xml .
COPY src ./src

# Compilamos el proyecto saltándonos las pruebas para ahorrar tiempo en el pipeline
RUN mvn clean package -DskipTests

# --- ETAPA 2: Ejecución (Runtime) ---
# Usamos una imagen de JRE oficial de Temurin basada en Alpine (Ultra ligera y segura)
FROM eclipse-temurin:17-jre-alpine

# BUENA PRÁCTICA: Mínimo privilegio
# En Alpine el comando cambia ligeramente de 'adduser' a 'adduser -D'
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

WORKDIR /app

# Copiamos solo el archivo .jar generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Exponemos el puerto, 8081 para Despacho
EXPOSE 8081

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]