#!/usr/bin/env bash
# Обработка ошибок, стоп если что-то не выполнилось
set -e
# Имя контейнера
CONTAINER_NAME="lab-docker-basic"

# Создаём папку для сертификатов, если её нет
mkdir -p certs

# Пересоздаём сертификат в папке
openssl req -x509 -nodes -days 180 -newkey rsa:2048 \
  -keyout certs/nginx.key \
  -out certs/nginx.crt \
  -subj "/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

# Ограничиваем права к приватному ключу
chmod 600 certs/nginx.key

# Проверяем конфигурацию nginx внутри контейнера, доступна ли ему папка
docker exec "${CONTAINER_NAME}" nginx -t

# Просим nginx перечитать конфиг и сертификаты
docker exec "${CONTAINER_NAME}" nginx -s reload

# Уведомление об успешном обновлении
echo "SSL-сертификат успешно обновлён, nginx перечитал конфигурацию."

# Показываем срок действия нового сертификата
openssl x509 -in certs/nginx.crt -noout -subject -dates
