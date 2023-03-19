# Домашнее задание к занятию "Память, управление памятью "

### Цель задания

В результате выполнения этого задания вы научитесь использовать утилиты для работы с памятью и настроите swap.

### Дополнительные материалы, которые пригодятся для выполнения задания

1. [Power management/Suspend and hibernate](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate)
2. [What is difference between Suspend and Hibernate in Linux](https://www.fosslinux.com/184/what-is-difference-between-suspend-and-hibernate-in-linux.htm)
3. [Процессы и память в Linux](https://xakep.ru/2021/03/05/linux-processes-and-memory/)
4. [Управление памятью](http://www.linuxlib.ru/kuznetsov/glava_20.html)
5. [Виртуальная память, swap](https://basis.gnulinux.pro/ru/latest/basis/49/49._%D0%92%D0%B8%D1%80%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F_%D0%BF%D0%B0%D0%BC%D1%8F%D1%82%D1%8C%2C_swap.html)

------

### 

### Задание 1

Что происходит с оперативной памятью во время перехода ПК в:

1. сон (suspend)
2. гибернацию (hibernate)

*Приведите ответ для каждого случая в свободной форме.*

1. *Во время сна в пямяти хранится текущее состояние компа, пямят находится под напряжением - электропитане не отключается, при пропадании питания текущее состояние компа будет потеряно, информация не сохранится*
2. *Во время гибернации текущее состояние машины записывается в swap, питание памяти отключается. Выход из режима гибернации длится дольше чем из сна*clear 

------

### 

### Задание 2

Определите объём используемой памяти и файла подкачки в вашей системе. Вывод сделайте в человекочитаемом формате.

*Приведите снимок экрана и ответ в свободной форме.*
![mem](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/1mem.PNG)

------

### Задание 3

Определите объем памяти, которая уже не используется процессами, но еще остается в памяти (ключевое слово - inactive).

*Примечание: при выполнении задания предполагается использование конструкции "{команда} | grep {параметр для фильрации вывода}"*

*Приведите снимок экрана и ответ в свободной форме.*
`grep -i inactive /proc/meminfo` \
![inactive](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/2inactive.PNG)

------

### Задание 4

1. Создайте скрин вывода команды `free -h -t`
![free1](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/3free_ht.PNG)
3. Создайте swap-файл размером 1Гб
```bash
sudo fallocate -l 1G /swapfile2 
sudo chmod 0600 /swapfile2 
sudo mkswap /swapfile2 
sudo swapon /swapfile2 
```
5. Добавьте настройку чтобы swap-файл подключался автоматически при  перезагрузке виртуальной машины (подсказка: необходимо внести изменения в файл `/etc/fstab`)
![fstab](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/4fstab.PNG)

7. Создайте скрин вывода команды `free -h -t`
![free2](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/5free.PNG)

7. Создайте скрин вывода команды `swapon -s`
![swapon2](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/6swapon.PNG)

9. Измените процент свободной оперативной памяти, при котором начинает  использоваться раздел подкачки до 30%. Сделайте скрин внесенного  изменения.\
`sudo sysctl vm.swappiness=30`  
![mem30](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/7swappines.PNG)
*В качестве ответа приложите созданные скриншоты*

------


## Дополнительные задания (со звездочкой*)

Эти задания дополнительные (необязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию.  Вы можете их выполнить, если хотите глубже и/или шире разобраться в  материале.


### Задание 5*

Найдите информацию про tmpfs.

*Расскажите в свободной форме, в каких случаях уместно использовать эту технологию.*

Создайте диск `tmpfs` (размер выберите исходя из объёма ОЗУ на ПК: 512Мб-1Гб), смонтируйте его в директорию `/mytmpfs`.

`sudo mkdir /mytmpfs`\
`sudo mount -t tmpfs -o size=512M tmpfs /mytmpfs`

*В качестве ответа приведите скрин вывода команды df- h до и после монтирования диска tmpfs.*

![df1](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/8df1.PNG)
![df2](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ2/9df2.PNG)

------


