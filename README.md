# Docker basics

Лабораторная по сборке и запуску простого Docker-контейнера с Nginx.

## Что внутри

- `Dockerfile` собирает образ на базе `nginx:alpine`.
- `index.html` копируется в стандартную директорию Nginx.
- `run_lab.sh` собирает образ `lab06_docker:latest` и запускает контейнер `lab-docker-basic`.

## Запуск

```bash
./run_lab.sh
```

После запуска страница доступна по адресу:

```text
http://localhost:54321
```

Проверить через терминал:

```bash
curl http://localhost:54321
```

## Остановка

```bash
docker rm -f lab-docker-basic
```

