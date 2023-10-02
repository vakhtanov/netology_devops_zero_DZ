# Kubernetes

Kubernetes (k8s) — фреймворк для запуска и управления приложениями в среде контейнеров.

* Объединяет несколько серверов в кластер с единым управлением и единым хранилищем конфигураций.
* Для запуска контейнеров использует docker (или другие).
* Основные принципы — это декларативный подход к описанию и идемпотентность.

## Объекты Kubernetes
Все объекты в kubernetes могут быть представлены в виде yaml или json файлов.\
Yaml — (Yet Another Markup Language) язык разметки, совместимый с json. Использует отступы и отсюда считается более читабельным. Можно как в питоне 4 пробела, но не обязательно.  

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

**Namespace** — пространство имен. Используется для разделения объектов по неким ритериям. Например, по окружению (prod,staging, ...) или по принадлежности к проекту (frontend, backend, ...)

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

## Некоторые комманды Kubernetes
```bash
kubectl apply -f nginx.yaml
kubectl get deploy
kubectl get rs
kubectl get po
kubectl describe po
kubectl logs --tail 100 nginx

kubectl exec -it nginx -- bash

kubectl expose deploy/nginx --port 80

kubectl run --rm -it test --image=curlimages/curl -- sh
```

# Установка minikub
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
      tier: redis
  template:
    metadata:
      labels:
        tier: redis
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

POD
```yaml
```

POD
```yaml
```
# create-vm "kubeadm3"

create-vm "minikube" # --memory 4
```
