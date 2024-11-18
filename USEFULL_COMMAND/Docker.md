# Docker - rконтейнеризация на уровне ОС

есть две версии - корпоративная с поддержкой и бесплатная

`https://devops.org.ru/docker-summary` - шпаргалки Devops

## альтернативы
* LXC
* Podman
* FreeBSD jail,
* OpenVZ,
* Solaris Containers
* Containerd

## ПОнятия
DockerFile - описание, настройки для создания собственого DockerImage
```
# Используем как основу последний образ Debian
FROM debian:latest
# Указываем создателя имиджа
MAINTAINER Test Netology
# Указываем версию
LABEL version="1.0"
# Указываем команду которая будет выполнена при сборке контейнера
RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata && apt
update && apt install -y apache2 nano
# Копируем файл внутрь нашего контейнера
#COPY ./index.html /var/www/html/index.html
# Включаем возможность прокидывать трафик на 80й TCP порт
EXPOSE 80/tcp
# Запускаем апач
CMD apachectl -D FOREGROUND
```
Docker Image – это стандартизированный образ\
`docker build -t netologytest1:1.1 .` - создать DockerImage из DockerFIle\
`docker image ls` - посмотреть список DockerImage

`docker run --name CONTAINERNAME -d -p 80:80 id_созданного_образа` - создать из DockerImage DockerContainer  и запустить его\
`-d` - для постоянной работы, фоновый режим\
`-p` - порт нашей машины:порт докера
`docker image history id_образа` - посмотреть слои образа - как коммиты в гите - изменения в образе

```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
[ OPTIONS ]
-it — интерактивный режим. Перейти в контейнер и запустить внутри контейнера команду
-d — запустить контейнер в фоне (демоном) и вывести его ID
-p port_localhost:port_docker_image — порты из докера на локалхост
-e «TZ=Europe/Moscow» — указываем нашему контейнеру timezone
-h HOSTNAME — присвоить имя хоста контейнеру
— link <имя контейнера> — связать контейнеры с другим
-v /local/path:/container/path/ — прокидываем в контейнер докера директорию с локальной машины
--name CONTAINERNAME — присвоить имя нашему контейнеру
--restart=[no/on-failure/always/unless-stopped] — варианты перезапуска контейнера при крэше
```

**Подключиться к контейнеру**

```bash
docker exec -it <container_id_or_name> /bin/bash
- Флаг -i позволяет взаимодействовать с контейнером (interactive), а флаг -t создает терминал (tty).
- Убедитесь, что в вашем контейнере установлен нужный shell (bash или sh). Некоторые минималистичные образы могут не иметь bash.

Если вы хотите выполнить одну команду без входа в интерактивный режим, вы можете сделать это так:
docker exec <container_id_or_name> <command>
```


Docker Container – запущенный Image - изменения в нем не влияют на другие контейнеры и на его образ\
Docker Hub - публичное хранилище DockerImage

## Установка Docker Engine на Debian
Можно попробовать простой способ работает в **UBUNTU**
**Это НЕ ОФИЦИАЛЬНЫЕ пакеты**
```bash
# Обновляем кеш
sudo apt update
# Устанавливаем необходимые пакеты
sudo apt install docker docker-compose docker.io -y
```


[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)
Устанавливаем пакеты для работы apt через HTTPS
```bash
# Обновляем кеш
sudo apt update
# Устанавливаем необходимые пакеты
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
# Добавляем GPG ключ
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Добавляем stable репозиторий для x86_64 / amd64
```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo \
tee /etc/apt/sources.list.d/docker.list > /dev/null


# Устанавливаем Docker Engine
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Запускаем Docker
sudo systemctl enable docker
sudo systemctl start docker
```
## Запускаем классический Hello World
`docker run hello-world` - запустит существующий Image или скачает с Хаба и заустит
```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete
Digest: sha256:f2266cbfc127c960fd30e76b7c792dc23b588c0db76233517e1891a4e357d519
Status: Downloaded newer image for hello-world:latest
```
`docker pull hello-world` - обновление контейнера\
`docker images`  - список локальных Images\
`docker container ls` - список работающих контейнеров\
`docker logs id_контейнера` - логи контейнера

поля в списке контейнеров CONTAINER ID – Идентификатор контейнера,  IMAGE – Образ, использованный при создании контейнера, COMMAND – Запущенная команда,  CREATED – Время, прошедшее с момента запуска,  STATUS – Статус контейнера, работает ли или завершил работу, PORTS – Проброшенные в контейнер порты,  NAMES – Случайно сгенерированное имя

`docker run имя_образа` - Находит\скачивает Image, создает из него контейнер и стартует созданный контейнер. Каждый раз создает новый контейнер

`docker start id_контейнера (или его имя)` Запускает уже существующий, но остановленный контейнер.\
Таким образом, вы можете запустить контейнер, произвести в нем какие-то настройки, остановить с помощью команды `docker stop` и потом запустить, не потеряв произведенные настройки

## Удаляем лишние образы
сперва надо удалить все контейнеры использующие образ \
`docker container ls -a`\
удаляем контейнеры\
`docker container rm id\имя_контейнера`\
удаляем образ \
`docker image rm hello-world`

# инфораструктура на Docker
Репозиторий Zabbix
[https://hub.docker.com/r/zabbix/zabbix-appliance](https://hub.docker.com/r/zabbix/zabbix-appliance)

**установим Zabbix** \
`docker run --name zabbix-appliance -p 80:80 -p 10051:10051 -d zabbix/zabbix-appliance:latest`

настройки контенера \
`sudo apt install zabbix-agent` \
`sudo docker container inspect zabbix-appliance` \
`sudo nano /etc/zabbix/zabbix_agentd.conf` - настраиваем zabbix agent (указываем IP zabbix aliance \
` sudo service zabbix-agent restart` - перезапускаем агента \

логин пароль по умолчанию Admin:zabbix

## docker-compose - управление многоконтейнерными приложениями
Скачиваем последний стабильный релиз из репозитория: \
`sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose` \
Устанавливаем права на запуск: \
`sudo chmod +x /usr/local/bin/docker-compose` \
Проверяем, что всё работает: \
`docker-compose --version` 

**docker-compose.yml - сценарий развертки контейнеров**
```
version: “3 # версия движка
  services:
networks: # сеть контейнеров
  netology-lesson:
    driver: bridge
    ipam:
      config:
        - subnet: 172.19.0.0/24

services:
  netology-db: база данных
    image: postgres:latest # Образ, который мы будем использовать
    container_name: netology-db # Имя, которым будет называться наш контейнер
    ports: # Порты, которые мы пробрасываем с нашего докер сервера внутрь контейнера
      - 5432:5432
    volumes: # Папка, которую мы пробросим с докер сервера внутрь контейнера
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment: # Переменные среды
      POSTGRES_PASSWORD: 123 # Задаём пароль от пользователя postgres
      POSTGRES_DB: netology_db # БД которая сразу же будет создана
      PGDATA: /var/lib/postgresql/data/pgdata # Путь внутри контейнера, где будет папка pgdata
    networks:
      netology-lesson:
        ipv4_address: 172.19.0.2
    restart: always # Режим перезапуска контейнера. Контейнер всегда будет  перезапускаться
```

проверка запуска\
```
sudo docker-compose up #запуск с выводом в консоль
sudo docker-compose up -d #запуск в бэкграунде
```
проверка работы постгрес\
```
telnet localhost 5432 #Проверяем подключаясь на порт телнетом
netstat -nlp | grep 5432 #Проверяем с помощью netstat. Если не стоит то apt install net-tools
sudo docker ps # Ищем контейнер и его порт
```

`sudo docker exec -it <имя_контейнера_или_id> bash` - подключиться к контейнеру

добавие еще сервис \
```
pgadmin:
  image: dpage/pgadmin4
  container_name: netology-pgadmin
  environment:
    PGADMIN_DEFAULT_EMAIL: netology@mymail.me
    PGADMIN_DEFAULT_PASSWORD: 123
  ports:
    - "8080:80"
  networks:
    netology-lesson:
      ipv4_address: 172.19.0.3
  restart: always
```

```
zabbix-server:
  image: zabbix/zabbix-server-pgsql
  links: # сервис запустится после указанного ниже севриса
    - netology-db
  container_name: netology-zabbix
  environment:
    DB_SERVER_HOST: '172.19.0.2'
    POSTGRES_USER: postgres
    POSTGRES_PASSWORD: 123
  ports:
    - "10051:10051"
  networks:
    netology-lesson:
      ipv4_address: 172.19.0.4
  restart: always
```

```
zabbix_wgui: # Фронт забикса
  image: zabbix/zabbix-web-apache-pgsql
  links:
    - netology-db
    - zabbix-server
  container_name: netology_zabbix_wgui
  environment:
    DB_SERVER_HOST: '172.19.0.2'
    POSTGRES_USER: 'postgres'
    POSTGRES_PASSWORD: 123
    ZBX_SERVER_HOST: "zabbix_wgui"
    PHP_TZ: "Europe/Moscow"
  ports:
    - "80:8080"
    - "443:8443"
  networks:
    netology-lesson:
      ipv4_address: 172.19.0.5
  restart: always
```

