# Ngnix custom simple proxy lb

this project is for crating a simple `docker` to run a proxy using only env variables

SAMPLE `docker-compose.yml `
```yml
version: "3"

services:
  meu-proxy:
    image: alexjonas/ngnix-proxy
    container_name: meu-proxy
    environment:
      - NODES=10.0.0.2,10.0.0.3
      - PORT=30002
      - VIRTUAL_HOST=www.alexjonas.com.br
      - VIRTUAL_PROTO=http
      - VIRTUAL_PORT=80
      - LETSENCRYPT_HOST=www.alexjonas.com.br
      - LETSENCRYPT_EMAIL=alexj.desantann@gmail.com
    restart: always
    networks:
      - nginx_proxy

networks:
  nginx_proxy:
    external:
      name: nginx-proxy_default

```