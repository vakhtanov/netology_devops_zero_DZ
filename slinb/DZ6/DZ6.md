# Домашнее задание к занятию «Ядро операционной системы»

### Цель задания

В этом задании вы на практике поработаете с модулями ядра Linux.

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Как работает ядро Linux.](https://linuxthebest.net/kak-rabotaet-yadro-linux-ob%D1%8Ayasnenye-anatomyy-yadra-linux/)
2. [Что такое ядро Linux.](https://losst.pro/chto-takoe-yadro-linux)
3. [Модули ядра.](https://help.ubuntu.ru/wiki/%D0%BC%D0%BE%D0%B4%D1%83%D0%BB%D0%B8_%D1%8F%D0%B4%D1%80%D0%B0)
4. [Управление модулями ядра Linux.](https://andreyex.ru/linux/upravlenie-modulyami-yadra-linux/)
5. [Модули ядра Linux.](https://hackware.ru/?p=12514)
6. [Команда strace в Linux.](https://losst.pro/komanda-strace-v-linux)

---

### Задание 1

При каких событиях выполнение процесса переходит в режим ядра?

*Напишите ответ в свободной форме.*

	в режим ядра выполение переходит при:
		* системных вызовах  когда необходима работа  с памятью, устройствами
		* аппаратных прерываниях - когда приходит сигнал об окончании действия на устройстве или ошибке

---

### Задание 2

Найдите имя автора модуля `libcrc32c`.

*В качестве ответа приложите снимок экрана с выводом команды.*

![autor](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ6/1Autor.PNG)

---

### Задание 3

Используя утилиту `strace`, выясните, какой системный вызов использует команда `cd`, чтобы сменить директорию.

Примечание

 1. Команда `cd` не является внешним файлом, но для наших целей можно использовать: `strace bash -c 'cd /tmp'`.
 2. При выводе `strace` вы можете увидеть много системных вызовов. Чтобы разобраться, за что отвечает каждый из них, можете воспользоваться встроенной помощью `man`.

*В качестве ответа напишите название системного вызова.*

`chdir("/tmp")`

![chdir](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ6/2cd.PNG)

---

## Дополнительные задания (со звездочкой*)

Эти задания дополнительные. Выполнять их не обязательно, и на зачёт они не повлияют. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

### Задание 4*

**Соберите свой модуль и загрузите его в ядро.**

Примечание: лучше использовать чистую виртуальную машину, чтобы нивелировать шанс сломать систему.

**1. Установим необходимые пакеты:**

`apt-get install gcc make linux-headers-$(uname -r)`

**2. Создаём файл модуля:**

```
mkdir kmod-hello_world
cd kmod-hello_world/
touch ./mhello.c
```

```
#define MODULE
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPLv3");

int init_module(void){
    printk("<1> Hello,World\n");
    return 0;
}

void cleanup_module(void){
    printk("<1> Goodbye.\n");
}
```

**3. Создаём Makefile:**

`touch ./Makefile`

```
obj-m += mhello.o

hello-objs := mhello.c

all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
```

_Обратите внимание, что отступы перед `make` — это табуляция, а не пробелы. Для синтаксиса Makefile это важно._

**4. Собираем модуль и устанавливаем его с помощью insmod.**

```
make all
insmod path/to/module.ko
```

*В качестве ответа приложите скриншот вывода установки модуля в `dmesg`.*

загрузили\
![insmod](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ6/3modinst.PNG)

выгрузили\
![remove](https://github.com/vakhtanov/netology_devops_zero_DZ/blob/main/slinb/DZ6/3unload.PNG)

-----

