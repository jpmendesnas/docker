# Estágio 1: Construir o aplicativo Go
FROM golang:1.16-alpine AS builder

WORKDIR /app

ADD . .

RUN go mod tidy
RUN go build -o main .

# Estágio 2: Configurar o NGINX e copiar o binário do aplicativo Go
FROM nginx:1.19-alpine

# Copiar o binário do aplicativo Go do estágio de construção
COPY --from=builder /app/main /app/main

# Copiar o arquivo de configuração do NGINX
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expor a porta do NGINX
EXPOSE 80

# Iniciar o NGINX e o aplicativo Go
CMD nginx && /app/main
