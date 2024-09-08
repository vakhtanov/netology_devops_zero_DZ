# Домашнее задание к занятию «Ansible.Часть 2»

### Оформление домашнего задания

1. Домашнее задание выполните в [Google Docs](https://docs.google.com/) и отправьте на проверку ссылку на ваш документ в личном кабинете.  
1. В названии файла укажите номер лекции и фамилию студента. Пример названия:  Ansible. Часть 2 — Александр Александров.
1. Перед отправкой проверьте, что доступ для просмотра открыт всем, у кого есть ссылка. Если нужно прикрепить дополнительные ссылки, добавьте их в свой Google Docs.

Вы можете прислать решение в виде ссылки на ваш репозийторий в GitHub, для этого воспользуйтесь [шаблоном для домашнего задания](https://github.com/netology-code/sys-pattern-homework).

---

### Задание 1

**Выполните действия, приложите файлы с плейбуками и вывод выполнения.**

Напишите три плейбука. При написании рекомендуем использовать текстовый редактор с подсветкой синтаксиса YAML.

Плейбуки должны: 

1. Скачать какой-либо архив, создать папку для распаковки и распаковать скаченный архив. Например, можете использовать [официальный сайт](https://kafka.apache.org/downloads) и зеркало Apache Kafka. При этом можно скачать как исходный код, так и бинарные файлы, запакованные в архив — в нашем задании не принципиально.

```yaml
---
- name: download_extract
  hosts: net
  become: true
  
  
  tasks:
    - name: Download archive
      get_url:
        url: "https://downloads.apache.org/kafka/3.8.0/kafka-3.8.0-src.tgz"
        dest: "/tmp/kafka-3.8.0-src.tgz"
    
    - name: mkdir
      file:
        path: "/tmp/unpack"
        state: directory

    - name: unpack
      unarchive:
        remote_src: yes
        src: "/tmp/kafka-3.8.0-src.tgz"
        dest: "/tmp/unpack"
```

![dz_play1-1_res](https://github.com/user-attachments/assets/4678d828-3be7-4e8c-b4e2-3945ce8ae664)


2. Установить пакет tuned из стандартного репозитория вашей ОС. Запустить его, как демон — конфигурационный файл systemd появится автоматически при установке. Добавить tuned в автозагрузку.

```yaml
---
- name: install, run tuned
  hosts: net
  become: true
  
  
  tasks:
    - name: install tuned
      apt:
        name: tuned
        state: present
    
    - name: run and startup
      service:
        name: tuned
        state: started
        enabled: yes
```

![dz_play1-2_res](https://github.com/user-attachments/assets/08e59825-4d01-407a-897f-8711aa95e15d)

3. Изменить приветствие системы (motd) при входе на любое другое. Пожалуйста, в этом задании используйте переменную для задания приветствия. Переменную можно задавать любым удобным способом.

```yaml
---
- name: change motd
  hosts: net
  become: true
  
  vars:
    string: Have a nice day!
    user: Vakhtanov
  
  tasks:
    - name: change motd
      copy:
        content: "{{ string }} \n {{ user }} \n"
        dest: /etc/motd
```


![dz_play1-3_res](https://github.com/user-attachments/assets/6efcc37e-e1cf-4832-a72d-6870c116679f)


![dz_play1-3_res2](https://github.com/user-attachments/assets/8465961e-fac1-4a38-abf1-65070e912dec)



### Задание 2

**Выполните действия, приложите файлы с модифицированным плейбуком и вывод выполнения.** 

Модифицируйте плейбук из пункта 3, задания 1. В качестве приветствия он должен установить IP-адрес и hostname управляемого хоста, пожелание хорошего дня системному администратору. 

```yaml
---
- name: change motd2
  hosts: net
  become: true
  
  vars:
    string: Have a nice day!
    user: Vakhtanov
  
  tasks:
    - name: change motd
      copy:
        content: "{{ string }} \n You IP: {{ ansible_facts.default_ipv4.address }} \n Host name: {{ ansible_facts.hostname }} \n" 

        dest: /etc/motd
```

![dz_play2_res](https://github.com/user-attachments/assets/f4521796-411c-417c-8329-112eb2177b8b)

![dz_play2_res2](https://github.com/user-attachments/assets/c0c0c9a8-36fb-4467-b2b8-614446ebf2a5)


### Задание 3

**Выполните действия, приложите архив с ролью и вывод выполнения.**

Ознакомьтесь со статьёй [«Ansible - это вам не bash»](https://habr.com/ru/post/494738/), сделайте соответствующие выводы и не используйте модули **shell** или **command** при выполнении задания.

Создайте плейбук, который будет включать в себя одну, созданную вами роль. Роль должна:

1. Установить веб-сервер Apache на управляемые хосты.
2. Сконфигурировать файл index.html c выводом характеристик каждого компьютера как веб-страницу по умолчанию для Apache. Необходимо включить CPU, RAM, величину первого HDD, IP-адрес.
Используйте [Ansible facts](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html) и [jinja2-template](https://linuxways.net/centos/how-to-use-the-jinja2-template-in-ansible/). Необходимо реализовать handler: перезапуск Apache только в случае изменения файла конфигурации Apache.
4. Открыть порт 80, если необходимо, запустить сервер и добавить его в автозагрузку.
5. Сделать проверку доступности веб-сайта (ответ 200, модуль uri).

В качестве решения:
- предоставьте плейбук, использующий роль;

```yaml
---
- name: apache_role
  hosts: net
  become: true
  

  roles:
    - role: specific-apache
```

- разместите архив созданной роли у себя на Google диске и приложите ссылку на роль в своём решении;

[specific-apache.zip](https://github.com/user-attachments/files/16922455/specific-apache.zip)

[specific-apache.tar](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/cicd/dz2_ansible/specific-apache.tar)

- предоставьте скриншоты выполнения плейбука;

![dz_play3_res1](https://github.com/user-attachments/assets/bdf966a7-9913-4133-be29-4f240453fb8c)

- предоставьте скриншот браузера, отображающего сконфигурированный index.html в качестве сайта.

![dz_play3_res4](https://github.com/user-attachments/assets/6a788518-e1c1-4bf6-ac3a-e9a203941e93)

![dz_play3_res5](https://github.com/user-attachments/assets/b7d2590d-d5c2-4484-9718-154173d57d16)


