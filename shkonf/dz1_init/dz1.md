# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](https://github.com/netology-code/08-ansible-01-base_02.25/blob/main/playbook) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

![1task](https://github.com/user-attachments/assets/1d998d9b-aad1-49b5-9b21-1c2a889db279)


2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

![2task](https://github.com/user-attachments/assets/09346fd9-c71f-4033-898e-dce7d9a60348)


3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

*compose.yaml*
```
version: "3"
services:
  rockylinux:
    image: rockylinux:9
    container_name: rockylinux9
    command:  bash -c "dnf install -y python3 && sleep infinity"


  ubuntu:
    image: ubuntu:22.04
    container_name: ubuntu22
    command: bash -c "apt update && apt install -y python3 && sleep infinity"
```

prod.yaml
```
  el:
    hosts:
      rockylinux9:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu22:
        ansible_connection: docker
```

*ansible.cfg*
```
[defaults]
interpreter_python:auto_silent
```

![3task](https://github.com/user-attachments/assets/c16585aa-f6f4-435c-9a54-79243b9a9d1c)



4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

![4task](https://github.com/user-attachments/assets/e412191d-3442-4f80-9495-6f47e59bdd3f)


5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![6task](https://github.com/user-attachments/assets/1cfa822b-6109-4d73-a4df-db0d88c1ad0d)


7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

![7task](https://github.com/user-attachments/assets/cc7e6cd0-de8f-4fb9-8ba7-b0115f2b5ff3)

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

![8task](https://github.com/user-attachments/assets/5b9dafaf-d206-4f27-ad20-c29fb327174f)

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

![9task](https://github.com/user-attachments/assets/89dae807-c4d4-4c10-8639-07dff32fc181)

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

*prod.yaml*
```
---
  el:
    hosts:
      rockylinux9:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu22:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![11task](https://github.com/user-attachments/assets/9abda9f8-0d3b-4764-b16e-39dc21c95e6d)

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.

compose.yaml
```
version: "3"
services:
  rockylinux:
    image: rockylinux:9
    container_name: rockylinux9
    command:  bash -c "dnf install -y python3 && sleep infinity"


  ubuntu:
    image: ubuntu:22.04
    container_name: ubuntu22
    command: bash -c "apt update && apt install -y python3 && sleep infinity"


```

6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Приложите ссылку на ваше решение в поле «Ссылка на решение» и нажмите «Отправить решение»
---
