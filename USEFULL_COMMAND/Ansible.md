![IAC](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/0f2e265a-bb2f-44f7-8f31-e7a2961d24e9)

Плюсы IAC
● Нет необходимости в ручной настройке
● Скорость — настройка («поднятие») инфраструктуры занимает заметно меньше времени
● Воспроизводимость — поднимаемая инфраструктура всегда идентична
● Масштабируемость — один инженер может с помощью одного и того же кода настраивать и управлять огромным количеством машин

![conf](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/9d9ca382-ed90-48c2-ba40-03fb171cdafc)

![ansible_sheme](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/625d2ac3-3a71-4193-8095-64922f0faa3b)

# Особенности Ansible
*Безагентный* — для работы, настройки с управляемым узлом нет необходимости ставить на управляемый узел агента. Необходимых требований только два: работающий ssh-сервер, python версии 2.6 и выше\
*Идемпотентность* — независимо от того, сколько раз вы будете запускать playbook, результат (конфигурация управляемого узла) всегда должен приводить к одному и тому же состоянию\
*Push-model* — изменения конфигураций «заталкиваются» на управляемые узлы. Это может быть минусом\
**КОНТРОЛИРОВАТЬ ВЕРСИЮ ПИТОНА НА УЗЛАХ**\
**ВНИМАТЕЛЬНО БЫТЬ С ВИНДОЙ**


**Основные термины Ansible**\
*Узел управления* — устройство с установленным и настроенным Ansible. Может быть ваш ноутбук или специальный узел в сети (подсети), выделенный для задач управления\
*Управляемые узлы* — узлы, конфигурация которых выполняется Файлы инвентаризации (inventory) — файл или файлы, в которых перечислены управляемые узлы: *.ini, *.yaml или динамический\
*Модули (modules)* отвечают за действия, которые выполняет Ansible, другими словами, инструментарий Ansible\

**Основные термины Ansible**\

*Задачи (tasks)* — отдельный элемент работы, которую нужно выполнить. Могут выполняться самостоятельно или в составе плейбука\
*Плейбук (playbook)* состоит из списка задач или других директив, указывающих на то, какие действия и где будут производиться\
*Обработчики (handlers)* — элемент, который служит для экономии кода и способен перезапускать службу при его вызове\
*Роли (roles)* — набор плейбуков и других файлов, которые предназначены для выполнения какой-либо конечной задачи. Также упрощают, сокращают код и делают его переносимым\

Устанавливаем Ansible:\
`yum install ansible/apt install ansible`\
Правим при необходимости конфигурационный файл Ansible:\
`vim /etc/ansible/ansible.cfg`\
Правим файл inventory по умолчанию или создаём свой:\
`vim /etc/ansible/hosts`\
Смотрим версию и другие переменные запуска Ansible:\
`ansible --version`\

[руководство](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html)

[конфиг ансибла](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)

**при установке выбирать один способ - либо APT либо PIP (через python)**

## Inventory

**ДЛЯ ANSIBLE создает отдельный каталог проекта в котором хранятся CFG и Inventory, этот каталог можно положить в GIT**

Инвентарный файл — это файл с описанием устройств, к которым будет подключаться и управлять Ansible. Может быть в формате INI или YAML, или быть динамически конфигурируемым какой- либо вычислительной системой. Две группы по умолчанию: all и ungrouped

```
[servers]
192.168.1.[1:5]

[another_servers]
my[A:C].example.com ansible_ssh_user=user # под каким пользователем подключаться по ssh

[all_servers:children]
servers
another_servers
```
[vagrant скрипт для развертывания виртуалок в VirtualBox](./ansible_dop/7-01.Vagrantfile)

Команды:\
`https://www.ssh.com/academy/ssh/keygen` - ssh ключи\
`ansible all -m ping --list-hosts — вывести список хостов`
`ansible-playbook --list-hosts — вывести список хостов для playbook`

Ansible.cfg — это основной конфигурационный файл. Может храниться:
● ANSIBLE_CONFIG — переменная окружения
● ansible.cfg — в текущем каталоге
● ~/.ansible.cfg — в домашнем каталоге пользователя
● /etc/ansible/ansible.cfg — можно брать за образец для внесения правок

`ansible --version — покажет, какой конфигурационный файл будет использоваться`

В конфигурационном файле можно задавать множество параметров, например:
```
[defaults]
inventory = inventory.ini # расположение файла inventory
remote_user = ansible # пользователь, которым подключаемся по ssh
gathering = explicit # отключает сбор фактов
forks = 5 # количество хостов, на которых текущая задача выполняется одновременно

[privilege_escalation]
become = True # требуется повышение прав
become_user = root # пользователь, под которым будут выполняться задачи
become_method = sudo # способ повышения прав
```

Большинство настроек также может задаваться или переопределять во время выполнения команд через параметры
```
ansible -i hosts.ini all -m ping — вручную указывает файл инвентори
ansible all -m ping -e "ansible_user=vagrant
ansible_ssh_pass=vagrant" — вручную задаёт удалённого пользователя и пароль
ansible all -u vagrant -m ping — вручную задаёт удалённого пользователя
ansible web* -m ping — задаёт список хостов к выполнению через регулярные выражения
ansible all -m setup - сбор информации с хостов
```

Настройка подключения к ВМ Vagrant:
1. В ВМ создаётся второй сетевой интерфейс, который включается в мост с сетевым интерфейсом в локальную сеть
2. В ВМ в конфигурационном файле sshd выставляется параметр PasswordAuthentication yes. Сервис перезапускается
3. С помощью команды ssh-copy-id vagrant@YOURIP копируется ключ на созданные ВМ для беспарольного входа
4. Создаётся директория под проект. Внутри директории создаются необходимые конфигурационные файлы
5. Проверка подключения: ansible all -m ping

Модули — это небольшая программа, входящая в поставку Ansible, принимающая на вход значения и выполняющая работу на целевых хостах. Фактически вся работа происходит с использованием модулей. Можно самостоятельно писать модули и расширять возможности Ansible

```
ansible-doc -l
ansible-doc shell
ansible all -m ping
```

Ad-hoc команды — это самый быстрый способ начать использовать Ansible. Для запуска Ansible в режиме ad-hoc не нужно писать плейбуки, достаточно помнить минимальный синтаксис
```
ansible all -m ping
ansible all -m command -a “cat /etc/hosts”
ansible all -m apt -v -a “name=mc state=present” - на всех хостах проверить есть ли бибилиотека, ксли нет - поставить
ansible all -m apt -v -a “name=mc state=present” -b - на всех хостах проверить есть ли бибилиотека, ксли нет - поставить с правами рута (-b)!
-v - debag
ansible all -m shell -v -a “whoami”
```
![modules](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/76acf02c-ee95-403a-8971-a0dd39ba230a)

# Плейбуки

![yaml](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/eb5f9dbf-d45e-46f1-b6e9-8bd741b91ac3)

**Разделение уровней только пробелами**

**Самое главное не запутаться в уровнях!!!**

[ямл за 5 мин](https://tproger.ru/translations/yaml-za-5-minut-sintaksis-i-osnovnye-vozmozhnosti#part4)

[пример плейбука](./ansible_dop/7-01.playbook.yml)

## запуск плейбука

`ansile-playbook ./palybook.yaml -v' \
`ansible-playbook myscript.yaml --syntax-check` - проверка синтаксиса

**полезные фичи в плейбуках**

`gather_facts: no - не собирать информацию о хостах` - можно поставить на уровне таски\
`ansible all -m setup` - сбор информации с хостов ad-hock коммандой 

таскам можно задать теги - для пропуска их при запуске плейбука
```
tags:
- init
- tag2
- nginx
ansile-playbook ./palybook.yaml -v -t nginx

ansible-playbook -i hosts.ini --tags prod playbook.yml
ansible-playbook -i hosts.ini --skip-tags prod playbook.yml
```

### Роли
ansible - можно сгенерировать роль - особоая настройка сервиса - хранится в папке проекта\
`ansible-galaxy init nginx` -p.\
`-p .` - скачивание в текущую папку - в папку проекта\
ansible-galaxy - хранилище ролей как контейнер в докер хаб - в системе - это структура папок в папке, например nginx, \
[galaxy.ansible.com](galaxy.ansible.com)\
```
ansible-galaxy role list
ansible-galaxy role init myrole
ansible-galaxy role search nginx
ansible-galaxy role install nginx
ansible-galaxy role remove nginx
```

есть папка **tasks** - там кусок плейбука для роли в плейбуке теперь вызываем роль\
```
roles:
  - include-role:
    name: nginx
    tasks_from: main
```

● ./roles — самый высокий приоритет
● ~/.ansible/roles
● /etc/ansible/roles
● /usr/share/ansible/roles — самый низкий приоритет


в папке **defaults** можно задавать действия по умолчанию или переменные\
переменные можно задавать во многих местах, максимальный уровень прекрития - ключ е\
`ansile-playbook ./palybook.yaml -v -t nginx -e "name=Netology"

[про переменные](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)\
[встроенные переменные](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)\
`ansible_play_hosts_all` — вернёт список хостов из inventory файла

у роли есть папка **vars** - в которой можно задавать переменные с максамальным приоритетом для роли\
обращение к переменной в ansible - ` "{{name}}" `\

папка **tests** - тесты для роль - ими оперирует МОЛЕКУЛА! \
папка **meta** - общая информация о роли. Сюда можно включить dependencies - зависимоти от других ролей\
папка **files** - из этой папки можно коммандой copy в роли скопировать файл куда надо\
папка **templates** - шаблоны с переменными, куда при копирвоании ansible подставит значения. Например для настройки первоначальной страницы Nginx\
расширение j2 - jinger2 - формат для шаблонов. в файле можно сслыласть на переменные как в ansible {{name}}\
папка **handlers** - папка с событиями или обработчиками запускаются при возникновернии определенных событий, например - изменение странцы - nginx нужно перезапустить\
в плейбуке роли - ` notify: "Reststart Nginx"`

в тасках можно задавать условия выполнения\
`when: os_name == "Ubuntu"` - ссылаемся на переменную или \
`when: ansible_facts['os_family'] == "Ubuntu"` - ссылаемся факты - информацию об узлах\


### Ansible-vault
хранение чувствиельных переменых - паролей\
можно зашировать любой файл, в том числе .yaml с паролями, потом при запуске плейбука указать ключ\
`ansile-playbook ./palybook.yaml -v --ask-vault-password`

```
ansible-vault create file2.yml
ansible-vault decrypt file2.yml - расшифровать
ansible-vault encrypt file2.yml - зашифровать
ansible-vault view file2.yml - посмотреть
ansible-vault edit file2.yml - редактировать
ansible-vault rekey file2.yml - изменить мастер палоль
```


## Донастройка ВМ вагранта 
```
Vagrant.configure("2") do |config|
   config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
   end
end
```

# Интерфейс для Ansible

**Ansible Tower** (RedHat) - граф интрефейс для ansible - если только для ansible\
бесплатный аналог **AWS project**

Jenkins - управление разнородными инструментами

Molecule - тестирование плуйбуков


# ПРимеры
```yaml
playbook
---
- name: Playbook 1 name
hosts: group1
roles:
- role1
- name: Playbook 2 name
hosts: group2,group3
tasks:
- name: task 1 in playbook 2
debug:
msg: “Hello World”
- name: task 2 in playbook 2
service:
name: sshd
state: restarted
...

```

```
roles
---
- name: roles example
hosts: servers
roles:
- role: role1
- role: role2
var1: one
var2: two
```

```yaml
handler
---
- name: handlers example
hosts: all
become: yes
tasks:
- name: Change ssh config
lineinfile:
path: /etc/ssh/sshd_config
regexp: '^PasswordAuthentication'
line: PasswordAuthentication yes
notify:
- Restart sshd
handlers:
- name: Restart sshd
service:
name: sshd
state: restarted
```
