# Домашнее задание к занятию "Дисковые системы"

### Цель задания

В результате выполнения этого задания вы:

1. Закрепите понимание работы дисковых систем в GNU/Linux.
2. Приобретете практические навыки настройки и администрирования блочных устройств в GNU/Linux.


### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Знакомство с технологией RAID](http://rus-linux.net/MyLDP/BOOKS/LSA/ch10.html)   
2. [Виртуальные файловые системы в Linux](http://rus-linux.net/MyLDP/file-sys/Virtual_filesystems_in_Linux.html)   
3. [Основы работы с утилитой mdadm](http://xgu.ru/wiki/mdadm)

---

### Задание 1

Какие виды RAID увеличивают производительность дисковой системы?

*Приведите ответ в свободной форме.*

__По опыту наибольший эффект в скорости дает RAID0, а в целом прирост производительности по сравнению с одним диском дадут 10, 01, 5, 50, 6, 60__
__RAID 1 - прироста в производитеьности не даст__


### Задание 2

Назовите преимущества использования VFS. Используется ли VFS при работе с tmpfs? Почему?

*Приведите развернутый ответ в свободной форме.*

__VFS дает единый универсальный инструмент доступа как к различным устройствам хранения, физическим, сетевым дискам и процессам.  VFS не используется при работе с tmpfs, обращение в tmpfs происходит посредством системмных вызовов. Потому, что эти файловые системы нужны до инициализации VFS__


### Задание 3

Подключите к виртуальной машине 2 новых диска. 

1. На первом диске создайте таблицу разделов MBR, создайте 4 раздела: первый раздел на 50% диска, остальные диски любого размера на ваше усмотрение. Хотя бы один из разделов должен быть логическим.

2. На втором диске создайте таблицу разделов GPT. Создайте 4 раздела: первый раздел на 50% диска, остальные любого размера на ваше усмотрение.

*В качестве ответа приложите скриншоты, на которых будет видно разметку диска (например, командами lsblk -a; fdisk -l)*

![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/1fdisk.PNG)

### Задание 4

Создайте программный RAID 1 в вашей ОС, используя программу `mdadm`.

Объем RAID неважен.

*В качестве ответа приложите скриншот вывода команды `mdadm -D /dev/md0`, где md0 - это название вашего рейд массива (может быть любым).*

![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/2raid.PNG)
---

## Дополнительные задания (со звездочкой*)
Эти задания дополнительные (необязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

### Задание 5*

Влияет ли количество операций ввода-вывода на параметр `load average`?

*Приведите развернутый ответ в свободной форме.*

__на параметр load average влиялет количество процессов в очереди если операции ввода вывода замедляют выполнение прцоесса, то количество процессов в очереди увеличиваеется__

### Задание 6*

1. Сделайте скриншоты вывода комманд df -h, pvs, lvs, vgs.
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_1.PNG)
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_1b.PNG)
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_1c.PNG)
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_1d.PNG)
  
2. Подключите к ОС 2 новых диска.  
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_2.PNG)

3. Создайте новую VG, добавьте в него 1 диск.
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_3.PNG)

4. Создайте 2 LV, распределите доступное пространство между ними поровну.
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_4.PNG)

5. Создайте на обоих томах файловую систему `xfs`.

  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_5.PNG)
  
6. Создайте две точки монтирования и смонтируйте каждый из томов.  
7. Сделайте скриншот вывода комманд df -h.
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_6.PNG)

8. Добавьте в VG второй оставшийся диск.
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_8.PNG)

9. Расширьте первый LV на объем нового диска.   
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_9.PNG)

10. Расширьте файловую систему на размер нового доступного пространства.   
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_10.PNG)

11. Сделайте скриншоты вывода комманд df -h, pvs, lvs, vgs.
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_11a.PNG)
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_11b.PNG)
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_11c.PNG)
  
  ![](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ4/zd6_11d.PNG)


*В качестве ответа приложите созданные скриншоты и скриншоты выполнения.*

