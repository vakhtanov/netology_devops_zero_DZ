# Домашнее задание к занятию «Базовые объекты K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера. 

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным Git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. Описание [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) и примеры манифестов.
2. Описание [Service](https://kubernetes.io/docs/concepts/services-networking/service/).

------

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.

[hello-world](task1.yml)

2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

`kubectl apply -f ./task1.yml`
`kubectl get pods`
`kubectl port-forward pod/hello-world 8081:8443`

<img width="559" height="189" alt="image" src="https://github.com/user-attachments/assets/f9ba3185-ee98-4233-9ca2-1fa47bf2f937" />

`curl -k https://127.0.0.1:8081'

<img width="482" height="467" alt="image" src="https://github.com/user-attachments/assets/b0b3e293-4f4d-4a9c-ad59-7288969567e1" />


------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.

[netology-web](task2_pod.yml)

2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.

[netology-svc](task2_svc.yml)

4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

   
`kubectl apply -f ./task2_pod.yml`

`kubectl apply -f ./task_svc.yml`

<img width="622" height="164" alt="image" src="https://github.com/user-attachments/assets/9733d664-ae5f-45ac-b29c-3fec33738f45" />


`kubectl port-forward --addresses 0.0.0.0 service/netology-svc 10443:10443`

<img width="736" height="148" alt="image" src="https://github.com/user-attachments/assets/f442c956-ad1e-4b24-8aac-b5b7574decfa" />


<img width="570" height="442" alt="image" src="https://github.com/user-attachments/assets/137735ac-36c3-4319-9c72-70f6dfb966c0" />


<img width="690" height="665" alt="image" src="https://github.com/user-attachments/assets/6ae37c0b-9030-4d8a-964c-5c272e7d88f7" />


------

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода команд `kubectl get pods`, а также скриншот результата подключения.

   <img width="413" height="94" alt="image" src="https://github.com/user-attachments/assets/4bdd3c54-2588-4fba-81cf-090fe19aee2f" />

4. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------

### Критерии оценки
Зачёт — выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики.

На доработку — задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки.
