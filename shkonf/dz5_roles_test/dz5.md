# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule и его драйвера: `pip3 install "molecule molecule_docker molecule_podman`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
### РЕШЕНИЕ ЗАДАЧА 1

#### Установка Ansible и molecule

инструкция установки молекулы

`https://ansible.readthedocs.io/projects/molecule/installation/`

пошаговые комманды для работы

**molecule берем версии 25.6 в более старших изменилась настройка драйвера - в лекциях не проходили**

```shell
molecule version 25.6

sudo apt update
sudo apt install -y python3-pip libssl-dev python3-venv
python3 -m venv venv
source venv/bin/activate

pip3 install ansible-core
pip3 install molecule==25.6
 #для новой версии
pip3 install ansible-dev-tools

## pip install  "molecule-plugins[podman]"
pip install  "molecule-plugins[docker]"

# если нужен докер инструкция https://github.com/docker/docker-install
curl -fs https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $USER

## Собственно молекула
## ansible-galaxy init vector-role
molecule init scenario --driver-name docker

-----------------образ для ansible------------
platforms:
  - name: instance_ubuntu
    image: "geerlingguy/docker-${MOLECULE_DISTRO:-ubuntu2204}-ansible:latest"
    command: ${MOLECULE_DOCKER_COMMAND:-""}
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
    cgroupns_mode: host
    privileged: true
    pre_build_image: true
---------------------------------------------

molecule test
```

#### 1

#### 2
<details>
  
<summary>результат выполнения команды: molecule init scenario --driver-name docker </summary>
  
```shell
(venv) user@ubuntusrv:~/ansible_dz5_role_test/playbook/roles/vector-role$ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...

PLAY [Create a new molecule scenario] ******************************************

TASK [Check if destination folder exists] **************************************
changed: [localhost]

TASK [Check if destination folder is empty] ************************************
ok: [localhost]

TASK [Fail if destination folder is not empty] *********************************
skipping: [localhost]

TASK [Expand templates] ********************************************************
skipping: [localhost] => (item=molecule/default/create.yml)
skipping: [localhost] => (item=molecule/default/destroy.yml)
changed: [localhost] => (item=molecule/default/molecule.yml)
changed: [localhost] => (item=molecule/default/converge.yml)

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Initialized scenario in /home/user/ansible_dz5_role_test/playbook/roles/vector-role/molecule/default successfully.
```
</details>

#### 3

<details>
  
<summary>результат выполнения команды: molecule test  </summary>

```shell
(venv) user@ubuntusrv:~/ansible_dz5_role_test/playbook/roles/vector-role$ molecule test
WARNING  Driver docker does not provide a schema.
WARNING  Driver docker does not provide a schema.
INFO     default ➜ discovery: scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     default ➜ prerun: Performing prerun with role_name_check=0...
INFO     default ➜ dependency: Executing
WARNING  default ➜ dependency: Missing roles requirements file: requirements.yml
WARNING  default ➜ dependency: Missing collections requirements file: collections.yml
WARNING  default ➜ dependency: Executed: 2 missing (Remove from test_sequence to suppress)
INFO     default ➜ cleanup: Executing
WARNING  default ➜ cleanup: Executed: Missing playbook (Remove from test_sequence to suppress)
INFO     default ➜ destroy: Executing
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance_ubuntu)
changed: [localhost] => (item=instance_debian)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=instance_ubuntu)
ok: [localhost] => (item=instance_debian)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     default ➜ destroy: Executed: Successful
INFO     default ➜ syntax: Executing

playbook: /home/user/ansible_dz5_role_test/playbook/roles/vector-role/molecule/default/converge.yml
INFO     default ➜ syntax: Executed: Successful
INFO     default ➜ create: Executing

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=instance_ubuntu)
ok: [localhost] => (item=instance_debian)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item=instance_ubuntu)
skipping: [localhost] => (item=instance_debian)
skipping: [localhost]

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item=instance_ubuntu)
skipping: [localhost] => (item=instance_debian)
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item=unix://var/run/docker.sock)
ok: [localhost] => (item=unix://var/run/docker.sock)

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/geerlingguy/docker-ubuntu2204-ansible:latest)
skipping: [localhost] => (item=molecule_local/geerlingguy/docker-debian13-ansible:latest)
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item=instance_ubuntu)
ok: [localhost] => (item=instance_debian)

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance_ubuntu)
changed: [localhost] => (item=instance_debian)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (298 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (297 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (296 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (295 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (294 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (293 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (292 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (291 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (290 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (289 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (288 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (287 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (286 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (285 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (284 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (283 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (282 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (281 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (280 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (279 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (278 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (277 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (276 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (275 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (274 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (273 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (272 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (271 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (270 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (269 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (268 retries left).
changed: [localhost] => (item=instance_ubuntu)
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (299 retries left).
changed: [localhost] => (item=instance_debian)

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     default ➜ create: Executed: Successful
INFO     default ➜ prepare: Executing
WARNING  default ➜ prepare: Executed: Missing playbook (Remove from test_sequence to suppress)
INFO     default ➜ converge: Executing

PLAY [Converge] ****************************************************************

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Get vector distrib] ***
changed: [instance_debian]
changed: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Update apt cache] ***
changed: [instance_debian]
changed: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Install vector] ***
ok: [instance_debian]
ok: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Deploy vector configuration] ***
changed: [instance_debian]
changed: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Flush handlers] ***

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Flush handlers] ***

RUNNING HANDLER [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Start vector service] ***
changed: [instance_ubuntu]
changed: [instance_debian]

PLAY RECAP *********************************************************************
instance_debian            : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
instance_ubuntu            : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     default ➜ converge: Executed: Successful
INFO     default ➜ idempotence: Executing

PLAY [Converge] ****************************************************************

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Get vector distrib] ***
ok: [instance_debian]
ok: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Update apt cache] ***
ok: [instance_debian]
ok: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Install vector] ***
ok: [instance_debian]
ok: [instance_ubuntu]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Deploy vector configuration] ***
ok: [instance_ubuntu]
ok: [instance_debian]

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Flush handlers] ***

TASK [/home/user/ansible_dz5_role_test/playbook/roles/vector-role : Flush handlers] ***

PLAY RECAP *********************************************************************
instance_debian            : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
instance_ubuntu            : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     default ➜ idempotence: Executed: Successful
INFO     default ➜ side_effect: Executing
WARNING  default ➜ side_effect: Executed: Missing playbook (Remove from test_sequence to suppress)
INFO     default ➜ verify: Executing
WARNING  default ➜ verify: Executed: Missing playbook (Remove from test_sequence to suppress)
INFO     default ➜ cleanup: Executing
WARNING  default ➜ cleanup: Executed: Missing playbook (Remove from test_sequence to suppress)
INFO     default ➜ destroy: Executing

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance_ubuntu)
changed: [localhost] => (item=instance_debian)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=instance_ubuntu)
changed: [localhost] => (item=instance_debian)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     default ➜ destroy: Executed: Successful
INFO     default ➜ scenario: Pruning extra files from scenario ephemeral directory
WARNING  Molecule executed 1 scenario (1 missing files)
(venv) user@ubuntusrv:~/ansible_dz5_role_test/playbook/roles/vector-role$
```
</details>

#### 4

```yaml

  - name: Check if vector is installed
  ansible.builin.command: which vector
  ignore_errors: yes
  - name: Assert Vector is installed
    ansible.builin.asserts:
      that: vector_installed.rc == 0
      msg: "Vector is not installed"
```

### РЕШЕНИЕ ЗАДАЧА 2

