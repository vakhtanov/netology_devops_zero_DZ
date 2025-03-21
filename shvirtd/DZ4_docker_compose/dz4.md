
# Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»

### Инструкция к выполению

1. Для выполнения заданий обязательно ознакомьтесь с [инструкцией](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD) по экономии облачных ресурсов. Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
2. Практические задачи выполняйте на личной рабочей станции или созданной вами ранее ВМ в облаке.
3. Своё решение к задачам оформите в вашем GitHub репозитории в формате markdown!!!
4. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

## Задача 1

Сценарий выполнения задачи:
- Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
- Если dockerhub недоступен создайте файл /etc/docker/daemon.json с содержимым: ```{"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]}```
- Зарегистрируйтесь и создайте публичный репозиторий  с именем "custom-nginx" на https://hub.docker.com (ТОЛЬКО ЕСЛИ У ВАС ЕСТЬ ДОСТУП);
- скачайте образ nginx:1.21.1;
- Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
```
- Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 (ТОЛЬКО ЕСЛИ ЕСТЬ ДОСТУП). 
- Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .

  --------
  [https://hub.docker.com/repository/docker/andreyvakhtanov/custom-nginx/general](https://hub.docker.com/repository/docker/andreyvakhtanov/custom-nginx/general)
  --------

## Задача 2
1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
- имя контейнера "ФИО-custom-nginx-t2"
- контейнер работает в фоне
- контейнер опубликован на порту хост системы 127.0.0.1:8080
2. Не удаляя, переименуйте контейнер в "custom-nginx-t2"
3. Выполните команду ```date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html```
4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

------------------------------------

![task2](https://github.com/user-attachments/assets/c1d2eb4a-24a7-4323-9dff-0f4ebcb1af68)

```bash
docker run  -d -p 127.0.0.1:8080:80 --name VakhtanovAndreySergeevich-custom-nginx-t2 andreyvakhtanov/custom-nginx:1.0.0

docker rename VakhtanovAndreySergeevich-custom-nginx-t2 custom-nginx-t2

date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ;
docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html

curl 127.0.0.1:8080
```
-----------------------------------------------

## Задача 3
1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
3. Выполните ```docker ps -a``` и объясните своими словами почему контейнер остановился.
4. Перезапустите контейнер
5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
8. Запомните(!) и выполните команду ```nginx -s reload```, а затем внутри контейнера ```curl http://127.0.0.1:80 ; curl http://127.0.0.1:81```.
9. Выйдите из контейнера, набрав в консоли  ```exit``` или Ctrl-D.
10. Проверьте вывод команд: ```ss -tlpn | grep 127.0.0.1:8080``` , ```docker port custom-nginx-t2```, ```curl http://127.0.0.1:8080```. Кратко объясните суть возникшей проблемы.
11. * Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно. [пример источника](https://www.baeldung.com/linux/assign-port-docker-container)
12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

----------------------------------------------------

![task3_1](https://github.com/user-attachments/assets/28e196e5-fa76-43c0-b8d5-121b9ecfabdf)

**в поток ввода контейнера был отправлен сигнал SIGINT для прерывания процесса, то есть nginx. процесс завершился, контейнер завершился.**

![task3_2](https://github.com/user-attachments/assets/ea5eeb48-2e79-403c-bd37-4a3d0518a691)
![task3_3](https://github.com/user-attachments/assets/644127bd-5aae-45bb-b4f1-2b5f7dc11c2b)


**порт 8080 перенаправляется на 80 порт, а nginx слушает 81**

```bash
docker attach custom-nginx-t2

docker ps -a
в поток ввода контейнера был отправлен сигнал SIGINT для прерывания процесса, то есть nginx. процесс завершился, контейнер завершился.

docker start custom-nginx-t2

docker exec -it custom-nginx-t2 bash

apt-get update > /dev/null 2>&1

apt-get install -y nano > /dev/null 2>&1

nano /etc/nginx/conf.d/default.conf

nginx -s reload

curl http://127.0.0.1:80; curl http://127.0.0.1:81

exit

ss -tlpn | grep 127.0.0.1:8080; docker port custom-nginx-t2; curl http://127.0.0.1:8080

порт 8080 перенаправляется на 80 порт, а nginx слушает 81

docker rm custom-nginx-t2 -f
```

------------------------------------


## Задача 4


- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера, используя ключ -v.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера. 
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в текущий каталог ```$(pwd)``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.


В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

---------------------------------
![task4](https://github.com/user-attachments/assets/e53860ee-ad63-40dc-abfb-12de0af5e798)

```bash
docker pull centos:centos8

docker pull debian

docker run -v $(pwd):/data -d --name centos centos:centos8 tail -f /dev/null

docker run -v $(pwd):/data -d --name debian  debian tail -f /dev/null

docker ps -a

docker exec centos  touch /data/first_file

echo some_text > second_file

docker exec debian ls /data
```
-------------------------------

## Задача 5

1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него.
"compose.yaml" с содержимым:
```
version: "3"
services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
"docker-compose.yaml" с содержимым:
```
version: "3"
services:
  registry:
    image: registry:2

    ports:
    - "5000:5000"
```

И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )

-------------------------------------
![task5_1](https://github.com/user-attachments/assets/be237dd9-570d-461f-af7f-61218f9dfafa)



**запустился compose.yaml, коммандой docker compose приоритет запуска имеет compose.yaml перед docker-compose.yaml запускается только первый**

-----------------------------
2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)

----------------------------------------

"compose.yaml" новый:
```
version: "3"
include:
  - docker-compose.yaml 

services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```   

![task5_2](https://github.com/user-attachments/assets/1c6bdc4d-93ba-4d1b-8cbd-56bbe6d9f9a8)

--------------------------------------------------


4. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/
--------------------------------------
![task5_3](https://github.com/user-attachments/assets/116273ea-8200-48ab-835f-07abcb668879)

```bash
docker image ls
docker tag andreyvakhtanov/custom-nginx:1.0.0 localhost:5000/custom-nginx:latest
docker image ls
docker push localhost:5000/custom-nginx:latest
```
----------------------------------------

6. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)
7. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local  окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:

```
version: '3'

services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```

------------------------------
![task5_4](https://github.com/user-attachments/assets/6d9ef5e2-b041-46a4-8689-0fa1bbd970ba)

возможно на хосте нужно будет сделать настройку

```bash
sudo nano /etc/docker/daemon.json

{
"insecure-registries": ["192.168.56.11:5000"]
}

sudo systemctl restart docker
```

---------------------------

6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".

---------------------------------
![task5_5](https://github.com/user-attachments/assets/904cf998-145f-431d-85bc-3a94e611f4e6)

---------------------------------

8. Удалите любой из манифестов компоуза(например compose.yaml).  Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод, файл compose.yaml , скриншот portainer c задеплоенным компоузом.

-----------------------
![task5_6](https://github.com/user-attachments/assets/b6b12818-29e9-4b7e-8db8-40e63cbcfa46)

![task5_8](https://github.com/user-attachments/assets/152011ae-8ea8-481e-9671-86ceb2435c31)

![task5_9](https://github.com/user-attachments/assets/b17d18e0-334a-4f72-a7dc-742189a35315)

**найден сиротский контейнер, потому, что нет в compose файле. можно его очистить**

"compose.yaml" :

```yml
version: "3"
include:
  - docker-compose.yaml 

services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```   
---------------------------------------------------


### Правила приема

Домашнее задание выполните в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

