# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.

[task1_depl1.yaml](task1/task1_depl1.yaml)



2. После запуска увеличить количество реплик работающего приложения до 2.

[task1_depl2.yaml](task1/task1_depl2.yaml)

3. Продемонстрировать количество подов до и после масштабирования.

![image](image/1start.JPG)

![image](image/2start2.JPG)

4. Создать Service, который обеспечит доступ до реплик приложений из п.1.

[task1_service.yaml](task1/task1_service.yaml)

5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

[task1_test_pod.yaml](task1/task1_test_pod.yaml)

`kubectl exec network-multitool -- curl -k nginx-multitool-service:10080`

![image](image/4nginx_work.JPG)


------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.

[task2_depl_nginx.yaml](task2/task2_depl_nginx.yaml)

2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.

![image](image/5get_init_pod.JPG)

3. Создать и запустить Service. Убедиться, что Init запустился.

[task2_service.yaml](task2/task2_service.yaml)

4. Продемонстрировать состояние пода до и после запуска сервиса.

![image](image/6_run_svc.JPG)

![image](image/7_serv_work.JPG)

------

### Правила приема работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов.
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------
