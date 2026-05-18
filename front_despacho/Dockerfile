# --- ETAPA 1: Construcción (Build) ---
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# --- ETAPA 2: Producción (Runtime) ---
# Usamos Nginx para servir el contenido estático
FROM nginx:stable-alpine

# Mínimo privilegio: Ajustamos permisos para que Nginx no necesite root absoluto
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /usr/share/nginx/html

USER nginx

# Copiamos los archivos compilados desde la etapa de Build
# Nota: La carpeta suele ser 'dist' o 'build' dependiendo de tu proyecto
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]