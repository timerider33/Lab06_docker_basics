#!/usr/bin/env bash
# Обработка ошибок
set -e
# Имя контейнера 
CONTAINER_NAME="lab-docker-basic"

# Создаём папку для сертификатов
mkdir -p certs

# Генерируем самоподписанный SSL-сертификат, если файла сертификата ещё нет
if [[ ! -f certs/nginx.crt ]]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout certs/nginx.key \
    -out certs/nginx.crt \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"
fi

# Права на приватный ключ
chmod 600 certs/nginx.key

# Сборка образа
docker build -t lab06_docker:latest .
# Удаляем предыдущие контейнеры если были запущены, если контейнера не было возвращаем True
docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
# Запуск с пробросом порта и указанием папки сертификата
docker run -d --name "${CONTAINER_NAME}" -p 54321:443 \
-v "/home/ops/projects/docker-basics/certs:/etc/nginx/certs:ro" \
 lab06_docker:latest
