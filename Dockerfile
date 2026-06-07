FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
# Копируем конфиг с SSL в image
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443
