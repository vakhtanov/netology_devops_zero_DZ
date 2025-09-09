# Задание 1

1. Установка microk8s по инструкции на виртуальную машину
```
sudo apt update
sudo apt install snapd
sudo snap install microk8s --classic
sudo usermod -a -G microk8s admin
sudo chown -f -R admin ~/.kube
newgr microk8s
```
<image src="image/task-1-1.png">

2. Проверим статус установки
```
microk8s status --wait-ready
```
<image src="image/task-1-2.png">

3. Устанавливаем dashboard и проверяем статус. В addons/enabled появился dashboard.
```
microk8s enable dashboard
microk8s status
```
<image src="image/task-1-3.png">
<image src="image/task-1-4.png">

4. Обновляем /var/snap/microk8s/current/certs/csr.conf.template. Добавляем внешний ip адрес сервера в блок alt_names
```
nano /var/snap/microk8s/current/certs/csr.conf.template
```
<image src="image/task-1-5.png">

5. Генерируем сертификат для подключения к внешнему ip адресу
```
sudo microk8s refresh-certs --cert front-proxy-client.crt
```
<image src="image/task-1-6.png">

# Задание 2

1. Устанавливаю kubectl на локальную машину
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```
<image src="image/task-2-1.png">

2. На сервере генерирую config файл для доступа к microk8s с локальной машины
```
microk8s config
```
<image src="image/task-2-2.png">

3. Копирую полученный файл на локальную машину в ~/.kube/config . Появляется доступ с локальной машины к серверу
```
kubectl version
kubectl get nodes
```
4. Подключаюсь к dashboard при помощи port-forward
```
kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443
```
<image src="image/task-2-3.png">

5. Для подключения необходим токен. На сервере генерирую токен
```
microk8s kubectl create token default
```
<image src="image/task-2-4.png">
<image src="image/task-2-5.png">

6. Через браузер подключаюсь к dashboard 
```
https://localhost:10443
```
<image src="image/task-2-6.png">
