# Kubernetes

Kubernetes (k8s) — фреймворк для запуска и управления приложениями в среде контейнеров.

* Объединяет несколько серверов в кластер с единым управлением и единым хранилищем конфигураций.
* Для запуска контейнеров использует docker (или другие).
* Основные принципы — это декларативный подход к описанию и идемпотентность.

### Объекты
Все объекты в kubernetes могут быть представлены в виде yaml или json файлов.\
Yaml — (Yet Another Markup Language) язык разметки, совместимый с json. Использует отступы и отсюда считается более читабельным.  

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
# create-vm "kubeadm3"

create-vm "minikube" # --memory 4
```
