# Домашнее задание к занятию «Kubernetes. Часть 1»

------ 

## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы. Это нужно, чтобы предупредить неконтролируемый расход средств, полученных после использования промокода.

Рекомендации [по ссылке](https://github.com/netology-code/sdvps-homeworks/tree/main/recommend).

---

### Задание 1

**Выполните действия:**

1. Запустите Kubernetes локально, используя k3s или minikube на свой выбор.
1. Добейтесь стабильной работы всех системных контейнеров.
2. В качестве ответа пришлите скриншот результата выполнения команды kubectl get po -n kube-system.

![1pod_list](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/6e9330cc-8e82-48a8-88fd-347ff34b77f3)
   

------
### Задание 2


Есть файл с деплоем:

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: master
        image: bitnami/redis
        env:
         - name: REDIS_PASSWORD
           value: password123
        ports:
        - containerPort: 6379
```

------
**Выполните действия:**

1. Измените файл с учётом условий:

 * redis должен запускаться без пароля;
 * создайте Service, который будет направлять трафик на этот Deployment;
 * версия образа redis должна быть зафиксирована на 6.0.13.

2. Запустите Deployment в своём кластере и добейтесь его стабильной работы.
3. В качестве решения пришлите получившийся файл.

**deploy**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: master
        image: bitnami/redis:6.0.13
        env:
         - name: ALLOW_EMPTY_PASSWORD
           value: "yes"
        ports:
        - containerPort: 6379
```

**service**
```yml
apiVersion: v1
kind: Service
metadata:
  name: redis-service
spec:
  selector:
    app: redis # Куда присоединятся
  ports: # проброс портов
    - protocol: TCP
      port: 6379
      targetPort: 6379
```

**доступность**

![2deploy](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/f682f10a-3a80-4d30-bcef-b22b45c5ae04)

------
### Задание 3

**Выполните действия:**

1. Напишите команды kubectl для контейнера из предыдущего задания:

 - выполнения команды ps aux внутри контейнера;

![31_ps_aux](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/efc880d2-e5e1-4fbd-a36b-40b64ba34b0f)
   
 - просмотра логов контейнера за последние 5 минут;

`kubectl logs --since=5m redis-7bfccd74cd-mbmsm`\
*за 5 минут в логах ничего нет`
   
 - удаления контейнера;

![33_del](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/527829bc-8fc0-4f2d-90ee-20312b434f1e)
   
 - проброса порта локальной машины в контейнер для отладки.

   `kubectl port-forward redis-7bfccd74cd-cdnd8 6379:6379`

   ![34](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/ba95afae-67ae-437a-808c-f308b15dbfb5)


2. В качестве решения пришлите получившиеся команды.

------
## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 4*

Есть конфигурация nginx:

```
location / {
    add_header Content-Type text/plain;
    return 200 'Hello from k8s';
}
```

**Выполните действия:**

1. Напишите yaml-файлы для развёртки nginx, в которых будут присутствовать:

 - ConfigMap с конфигом nginx;
 - Deployment, который бы подключал этот configmap;
 - Ingress, который будет направлять запросы по префиксу /test на наш сервис.

2. В качестве решения пришлите получившийся файл.
