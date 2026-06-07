#!/usr/bin/env bash
set -e

CONTAINER_NAME="lab-docker-basic"

docker build -t lab06_docker:latest .
# Удаляем предыдущие контейнеры если были запущены
docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true

docker run -d --name "${CONTAINER_NAME}" -p 54321:80 lab06_docker:latest
