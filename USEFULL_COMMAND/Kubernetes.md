# Kubernetes

Kubernetes (k8s) — фреймворк для запуска и управления приложениями в среде контейнеров.

[https://kubernetes.io/ru/docs/home/](https://kubernetes.io/ru/docs/home/)\
[https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/)

* Объединяет несколько серверов в кластер с единым управлением и единым хранилищем конфигураций.
* Для запуска контейнеров использует docker (или другие).
* Основные принципы — это декларативный подход к описанию и идемпотентность.

## Объекты Kubernetes
Все объекты в kubernetes могут быть представлены в виде yaml или json файлов.\
Yaml — (Yet Another Markup Language) язык разметки, совместимый с json. **Использует отступы и отсюда считается более читабельным.** **Обычно используется 2 пробела.** Табуляция не применяется.  

пример объекта
```
apiVersion: v1 #версия API
kind: Service #тип объекта
metadata: # метаданные для создания объекта - не влияют на конфигурацию и имена контейнеров
  name: nginx
  namespace: default
  labels:
    env: production
    version: 1.0
spec: # параметры объекта
  selector:
    app: nginx
  ports:
    - name: http
      port: 80
      targetPort: 80
```
после создания появялется еще `status`

**Namespace** — пространство имен. Используется для разделения объектов по неким ритериям. Например, по окружению (prod,staging, ...) или по принадлежности к проекту (frontend, backend, ...). Отдельная область для запуска подов и сервисов - например DEV.

Объекты условно можно разделить на:
* namespaced — привязанные к namespace,
* cluster-level — глобальные объекты.

**Labels** — лейблы. С их помощью реализован поиск объектов. И как следствие, их модификация. Если имя объекта динамическое и заранее невозможно его знать, то поиск таких объектов осуществляется с помощью лейблов.

## Примитивы Kubernetes

**Pod** — минимальная единица рабочей нагрузки.\
обычно pod = контейнер или несколько. минимальная рабочая еденица\
под запустился и работает - за его состоянием никто не следит

**ReplicaSet** - создает несколько копий пода и поддеживает их работоспособность. Обычно используется для приложений не хранящих данные - нет уникального имени у пода

**Job** — разовый запуск пода. Обычно используется для бутстрапа или миграций

**CronJob** — Запуск Job по расписанию.

**Deployment** - задает шаблон replicaset и занимается выкаткой приложений. При изменении объекта создается новый replicaset, и одновременно со старым они начинают апскейлиться и даунскейлиться соответсвенно. По сути заменят старый реплика сет на новый с контролем работоспособности.

**DaemonSet** ведет себя аналогично деплойменту.  поднимает по 1 поду на каждой ноде. Используется для приложений, которые необходимо держать на каждой ноде, например, node-exporter и.т.п

**StatefulSet** — используется для деплоя кластерных приложений. Каждый под в нем имеет фиксированное имя, на которое можно сослаться в конфиге. Для приложений сханящих данные

**ConfigMap** — используется для хранение конфигурации (констант, настроек с именами, которые можно вызывать из контейнеров). Можно хранить как переменные окружения, так и файлы конфига целиком.

**Secret** — используется для хранения любой чувствительной информации (пароли, ключи и.т.п). В etcd хранится в зашифрованном виде (base64). Может иметь один из нескольких типов:
  ● Opaque
  ● kubernetes.io/service-account-token
  ● kubernetes.io/dockercfg
  ● kubernetes.io/dockerconfigjson
  ● kubernetes.io/basic-auth
  ● kubernetes.io/ssh-auth
  ● kubernetes.io/tlsdata
  ● bootstrap.kubernetes.io/token

**Service** — используется для направления трафика на под и балансировки в случае, если подов несколько. По умолчанию сетевой доступ будет обеспечен только внутри
кластера. Имя сервиса будет использоваться в качестве DNS. По сути - Внешний доступ к поду внешенее подключение

**Ingress** — объект, обрабатываемый ingress контроллером, реализует внешнюю балансировку (обычно по HTTP). Балансировка нагрузки на сервис?

## Некоторые комманды Kubernetes
```bash
kubectl apply -f nginx.yaml
kubectl get deploy #Деплои
kubectl get rs #реплики
kubectl get po #поды
kubectl describe po
kubectl logs --tail 100 nginx
kubectl get service
или
kubectl get svc
kubectl delete service nginx-service

kubectl get po -n kube-system # поды в наймспеййсе

kubectl exec -it nginx -- bash

kubectl expose deploy/nginx --port 80

kubectl run --rm -it test --image=curlimages/curl -- sh
```
[https://itshaman.ru/articles/715/shpargalka-po-komandam-kubernetes](https://itshaman.ru/articles/715/shpargalka-po-komandam-kubernetes)

# Установка minikub — компактная версия k8s, созданная для тестирования и разработки в среде k8s. А также в учебных целях
инструкция по установке
[https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/)

**УСТАНОВКА с ОФИЦИАЛЬНОЙ версией докера**
[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)\

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

### KUBECTL
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

### MINIKUBE
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start
```
Вариант установки KubeCTL
`minikube kubectl -- get pods -A`

# аналоги minikube k3s
k3s — аналог minikube, эмулирующий k8s. Запускается с помощью одного бинарного файла.
Установка возможна на linux с помощью bash скрипта:
`curl -sfL https://get.k3s.io | sh -`

Полная инструкция по установке доступна по ссылке:
[https://rancher.com/docs/k3s/latest/en/quick-start/](https://rancher.com/docs/k3s/latest/en/quick-start/)

Запуск: `service k3s start`

# Kubectl — основная утилита для работы с k8s кластером.
[https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)

Использует конфигурацию, расположенную в файле `~/.kube/config`\
Переопределить расположение этого файла можно с помощью переменной KUBECONFIG.

Oбщий синтаксис: `kubectl действие объект флаги`\
Например: `kubectl get pods -n kube-system`\

Действия: get,  create,  edit,  delete,  describe,  apply\
Объекты: pods, deploy, svc,  secrets,  ...\
Флаги могут различаться для различных команд, из основных необходимо указывать namespace:  -n, --all-namespaces

Создаем файл: `nginx.yaml`\
Деплоим с помощью: `kubectl apply -f nginx.yaml`
Смотрим за статусом: `kubectl get po`
Смотрим подробный статус пода: `kubectl describe po имя_под`

Аналогом docker logs в k8s является команда `kubectl logs`:\
`kubectl logs --tail 100 имя_пода`\
Для того чтобы выполнить внутри пода какую-либо команду, используется:\
`kubectl exec -it имя_пода команда`\
Пример: `kubectl exec -it nginx-ans2l bash`

# Создание виртуальных машин Yandex из коммандной строки
```bash
#!/bin/bash
set -e

function create-vm {
    local NAME=$1

    YC=$(cat <<END
        yc compute instance create \
        --name $NAME \
        --hostname $NAME \
        --zone ru-central1-a \
        --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,size=20,type=network-ssd \
        --memory 4 \
        --cores 2 \
        --ssh-key ~/.ssh/yandex.pub
END
)
    eval "$YC"
}

# create-vm "kubespray1"
# create-vm "kubespray2"
# create-vm "kubespray3"

# create-vm "kubeadm1"
# create-vm "kubeadm2"
# create-vm "kubeadm3"

create-vm "minikube" # --memory 4
```

# Примеры примитивов Kubernetes
POD
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  labels:
    role: myrole
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
```

ReplicaSet
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: redis
  labels:
    tier: redis 
spec:
  replicas: 1
  selector:
    matchLabels:
      tier: redis #эти имена должны совпадать
  template:
    metadata:
      labels:
        tier: redis #эти имена должны совпадать
    spec:
      containers:
      - name: redis
        image: redis
```

Jobs
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      containers:
      - name: pi
        image: yii
        command: yii migrate
      restartPolicy: Never
  backoffLimit: 4
```

CronJobs
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            imagePullPolicy:
IfNotPresent
            command:
            - /bin/sh
            - -c
            - date; echo Hello
```

Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
    containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
      - containerPort: 80
```

DaemonSet
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluent-bit
spec:
  selector:
    matchLabels:
      name: fluent-bit
template:
    metadata:
      labels:
        name: fluent-bit
    spec:
      containers:
      - name: fluent-bit
        image: fluent-bit:1.6
```

StatefulSet
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
          name: web
```

ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: backend-conf
data:
  config.yaml: | # поду можно передать имя этого конфига или обращаться прямо к переменным
    db_host: mysql
    db_user: root
```

Secret
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-basic-auth
type: kubernetes.io/basic-auth
stringData:
  username: admin
  password: t0p-Secret
```

Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp # Куда присоединятся
  ports: # проброс портов
    - protocol: TCP
      port: 80
      targetPort: 9376
```

Ingress 
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
spec:
  rules:
  - http:
    paths:
    - path: /testpath
      pathType: Prefix
      backend:
        service:
          name: test
          port:
            number: 80
```


