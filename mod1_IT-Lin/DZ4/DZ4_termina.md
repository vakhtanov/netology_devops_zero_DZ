# Домашнее задание к занятию "Основы работы в терминале ОС Linux"

### 

### Цель задания

В результате выполнения этого задания вы:
- научитесь запускать и просматривать процессы;
- научитесь выполнять базовую настройку сети в ОС Linux;
- начнете работу с утилитами ps, kill, htop;
- добавите в виртуальную машину сетевые адаптеры и настроите их для ОС Linux.


### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Статья про htop на habr](https://habr.com/ru/post/316806/)
2. [Инструкция по htop](https://zalinux.ru/?p=3581)
3. [Настройка сети в Ubuntu](https://tehnichka.pro/configure-net-in-ubuntu/)
4. [Configuring IP Networking with GNOME GUI](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_gnome_gui)
5. [How to Configure Network Settings in Ubuntu](https://vitux.com/ubuntu-network-configuration/)


### Задание 1. Процессы

1. Запустите текстовый редактор nano
2. Откройте ещё одно окно терминала
3. С помощью команды `ps` определите PID запущенного процесса
4. Выполните команду `kill PID`

Что произошло в терминале с nano?

*Ответ приведите в виде последовательности команд и снимка экрана*
`tmux` утилита для нескльких терминалов\
`nano testfile` \
_ctrl+b c_ - новое окно \
`pgrep nano` \
вывод 6333 \
`kill 6333`
_ctrl+b 0_ - на экран nano \

![nano terminate](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/mod1_IT-Lin/DZ4/nano_term.PNG)



### Задание 2. Утилита htop

1. Установите утилиту htop
2. С помощью htop ответьте на вопросы:
   - Какие процессы занимают больше всего памяти?
   ![max_mem](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/mod1_IT-Lin/DZ4/max_mem.PNG)
   - Какие процессы занимают больше всего процессорного времени?
   ![max_cpu](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/mod1_IT-Lin/DZ4/max_cpu.PNG)

*Приведите ответ в виде снимков экрана*


### Задание 3. Работа с сетью

1. Добавьте в виртуальную машину два дополнительных сетевых адаптера с внутренней (internal) сетью
2. Настройте на первом из них адрес 10.1.0.1 маску подсети 255.0.0.0
3. Настройте на втором из них адрес 10.2.0.1 маску подсети 255.0.0.0
4. На обоих интерфейсах настройте адрес dns-сервера как 8.8.8.8 и шлюз по умолчанию 10.1.1.1
5. Выполните команду ip addr

*Приведите ответ в виде снимка экрана с выполненной командой ip addr*

_Принтскрин из VirtualBox_\
![VM](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/mod1_IT-Lin/DZ4/ip_conf_VM.PNG)\
**Тут все понятно**

Как основную систему использую Ubuntu с запуском через Vagrant, принт скрин ниже\
![vagrant](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/mod1_IT-Lin/DZ4/ip_conf_vagr.PNG)

Вагрант файл настроил по интернету))\
```vagrant

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-20.04"
  config.vm.network "private_network", ip: "10.1.0.1", netmask:"255.0.0.0"
  config.vm.network "private_network", ip: "10.2.0.1", netmask:"255.0.0.0"
  
  config.vm.provision "shell",
  run:"always",
  inline: "route add default gw 10.1.1.1"
  
end
```
**ПРОШУ КОММЕНТАРИЙ И ЗАМЕЧАНИЙ**


