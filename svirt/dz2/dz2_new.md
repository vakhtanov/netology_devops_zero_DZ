# Домашнее задание к занятию «Типы виртуализации: KVM, QEMU»
---

## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы предупредить неконтролируемый расход средств, полученных после использования промокода.

Рекомендации [по ссылке](https://github.com/netology-code/sdvps-homeworks/tree/main/recommend).

---


### Задание 1 

Выполните действия и приложите скриншоты по каждому этапу:

1. Установите QEMU в зависимости от системы.
   
![1QEMU_inst](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/f9cf33a3-800c-4a64-a78d-e88a8762e992)
   
3. Создайте виртуальную машину.

![2QEMU_create](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/a8d07b32-53fa-4d0a-b4da-f8ffdc7d1c46)

4. Установите виртуальную машину.
Можете использовать пример [по ссылке](https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/x86/alpine-standard-3.13.5-x86.iso). Пример взят [с сайта](https://alpinelinux.org). 

![3QEMU_inst_sys](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/20a840f1-cf04-4e59-ac36-619cad418131)\
![4QEMU_alpine_log](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/63da1fc1-4311-4ec9-97f1-a8eb2fbd9608)


Если KVM уже установлен, создайте ВМ без использования аппаратной виртуализации.  
В случае использования `virt-install` используйте параметр `--virt-type=qemu`.
 




### Задание 2 

Выполните действия и приложите скриншоты по каждому этапу:

1. Установите KVM и библиотеку libvirt.

![KVM_on](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/ed75fae9-76b5-45d2-b1ba-dca7c2fbb9da)

![packinst](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/2c25245d-bf4d-4ba2-8d71-b8f40ebeb096)

   
3. Создайте виртуальную машину.

![alpine_dist](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/5c455c12-ac34-4e72-bfd3-905751981b4f)

![make_disk](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/37c8194f-6e92-498b-851d-de69fb412625)



5. Установите виртуальную машину. 
![alpine_install](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/f837128d-5e00-40b8-bc93-5f8657993208)

![alpine_login](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/337732b0-3585-4d81-8773-255e85a1652f)


В случае использования `virt-install` используйте параметр `--virt-type=kvm`.




### Задание 3 

Напишите, как изменилось время установки и старта системы при аппаратной виртуализации (KVM) по сравнению с программной эмуляцией (QEMU).

*При создании в режиме KVM - машина создалась значительно быстрее*

---

## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.


### Задание 4*

1. Установите виртуальные (alpine) машины двух различных архитектур, отличных от X86 в QEMU.
1. Приложите скриншоты действий.



### Задание 5*

1. Установите виртуальные (alpine) машины двух различных архитектур, отличных от X86 в KVM.
1. Приложите скриншоты действий.
