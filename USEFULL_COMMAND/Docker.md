# Docker - rконтейнеризация на уровне ОС

есть две версии - корпоративная с поддержкой и бесплатная

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

`docker run -d -p 80:80 id_созданного_образа` - создать из DockerImage DockerContainer  и запустить его\
`docker image history id_образа` - посмотреть слои образа - как коммиты в гите - изменения в образе\

Docker Container – запущенный Image - изменения в нем не влияют на другие контейнеры и на его образ\
Docker Hub - публичное хранилище DockerImage

## Установка Docker Engine на Debian
Можно попробовать простой способ
```bash
# Обновляем кеш
sudo apt update
# Устанавливаем необходимые пакеты
sudo apt install docker docker-compose docker.io -y
```



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

