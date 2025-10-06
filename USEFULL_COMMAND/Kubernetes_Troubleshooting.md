# Cluster
## Проверка API-сервера

### Проверить подключение к API-серверу (удалённо, локально)
```
kubectl get nodes
The connection to the server 51.250.10.123:6443 was refused - did you specify the right
```
### Проверить статус kubelet, container runtime2
```
systemctl status kubelet
systemctl status docker
```
### Получить дамп системы3
`kubectl cluster-info dump`

# Проверка Node
## Проверить состояние нод
kubectl get nodes
kubectl get node node_name -o yaml
## Проверить статус kubelet, container runtime на нодах
systemctl status kubelet
kubectl describe nodes node_name
systemctl status docker

Проверка состояния системных pod
Проверить состояние pod в namespace kube-system1
kubectl get pods -n kube-system
kubectl describe pod node_name -n kube-system
Проверить статус сервисов на control plane, если они запущены в виде сервисов2
systemctl status kube-apiserver
systemctl status kube-scheduler

# Журналы логов
## Проверка логов
Проверить логи сервисов kubelet, container runtime1
journalctl -u kubelet
journalctl -u docker
Проверить логи системы2
less /var/log/kube-apiserver.log
less /var/log/kube-scheduler.log
less /var/log/kube-controller-manager.log
## Проверка логов системных подов
Проверить логи системных подов, если они запущены как поды3
kubectl logs -n kube-system kube-apiserver-****
kubectl logs -n kube-system kube-scheduler-****
kubectl logs -n kube-system kube-controller-manager-****

# Application
## Проверка работы приложения
Проверить статус подов1
kubectl get pods (-n namespace_name)
kubectl get pods (-n namespace_name) -o wide
Запуск команды внутри контейнера пода2
kubectl exec pod_name (-n namespace_name) -- command
kubectl describe pod pod_name (-n namespace_name)
kubectl exec pod_name (-n namespace_name) -c container_name -- command
Проверить лог подов
kubectl logs pod_name
kubectl logs pod_name (-n namespace_name) -c container_name

# Network
## Проверка работы сети
Проверить логи подов kube-proxy, coredns1
kubectl logs -n kube-system kube-proxy-****
kubectl describe kube-system coredns-****
Используя специальные поды с сетевыми тулами, провести диагностику2
kubectl exec multitool -- command
kubectl exec netshoot -- command

# Troubleshooting roadmap

![road_map.png](road_map.png)
