# --- ETAPA 1: Compilación (Build) ---
# Usamos una imagen con JDK y Maven para construir el proyecto
FROM maven:3.8.5-openjdk-17-slim AS build

# Definimos el directorio de trabajo
WORKDIR /app

# Copiamos el archivo de configuración de Maven y el código fuente
COPY pom.xml .
COPY src ./src

# Compilamos el proyecto saltándonos las pruebas para ahorrar tiempo en el pipeline
RUN mvn clean package -DskipTests

# --- ETAPA 2: Ejecución (Runtime) ---
# Usamos una imagen de JRE mucho más ligera y segura
FROM eclipse-temurin:17-jre-alpine

# BUENA PRÁCTICA: Mínimo privilegio
# Creamos un usuario de sistema para no ejecutar la app como 'root'
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring:spring

WORKDIR /app

# Copiamos solo el archivo .jar generado en la etapa anterior
# Nota: Asegúrate de que el nombre coincida con el generado por tu pom.xml
COPY --from=build /app/target/*.jar app.jar

# Exponemos el puerto 8080 para Ventas
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]