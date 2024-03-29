# Домашнее задание к занятию «Виртуализация и облачные решения: AWS, GCP, Yandex Cloud, OpenStack»

---

## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы предупредить неконтролируемый расход средств, полученных после использования промокода.

Рекомендации [по ссылке](https://github.com/netology-code/sdvps-homeworks/tree/main/recommend).

---

### Задание 1
 
**Ответьте на вопрос в свободной форме.**

Чем частное облако отличается от общедоступного, публичного и гибридного?

    Частное облако расположено на ресурсах пользователя (организации)
    Обслуживанием частного облака занимается IT отдел пользователя
 
---

### Задание 2 


Что обозначают: IaaS, PaaS, SaaS, CaaS, DRaaS, BaaS, DBaaS, MaaS, DaaS, NaaS, STaaS? Напишите примеры их использования.

    IaaS - инфраструктура как сервис - Яндекс.Облако
    PaaS - платформа как сервис Google Cloud
    SaaS - программа как сервис Microsoft Office 365
    CaaS - коммуникация как сервис - телефония
    DRaaS - аварийное восстановление как сервис - UCloud
    BaaS - бекап как сервис - сохранение данных телфона в Goolge акаунт
    DBaaS - база данных в облаке - MongoDB
    MaaS - мониторинг как сервис
    DaaS - рабечее место как сервис - работа с виртулаьной? машиной через удаленной рабочий стол
    NaaS - сеть как сервис - обычно поставляется вместе с IaaS
    STaaS - хранлище как услуга - Облако Маил ру
 
---

### Задание 3 
 
**Ответьте на вопрос в свободной форме.**

Напишите, какой вид сервиса предоставляется пользователю в ситуациях:
 
1. Всеми процессами управляет провайдер.
    *Saas*
1. Вы управляете приложением и данными, остальным управляет провайдер.
    *Paas*
1. Вы управляете операционной системой, средой исполнения, данными, приложениями, остальными управляет провайдер.
    *Iaas*
1. Вы управляете сетью, хранилищами, серверами, виртуализацией, операционной системой, средой исполнения, данными, приложениями.
    *собственная инфораструктура*
 
---
 
### Задание 4 
 
 
Вы работаете ИТ-специалистом в своей компании. Перед вами встал вопрос: покупать физический сервер или арендовать облачный сервис от [Yandex Cloud](https://cloud.yandex.ru).
 
Выполните действия и приложите скриншоты по каждому этапу:

1. Создать платёжный аккаунт:
  - зайти в консоль;
  - выбрать меню биллинг; 
  - зарегистрировать аккаунт.
    ![1_Acca](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/5a22ce5d-2eac-4b42-b358-b9340635d176)

    
1. После регистрации выбрать меню в консоли Computer cloud.

   ![2_menu](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/d16d268c-7716-4158-8f7c-a5d3c7cadd6e)

1. Приступить к созданию виртуальной машины.

   ![3_vm](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/edb7fe71-2661-4ae6-a36a-0fd011c51503)

 
**Ответьте на вопросы в свободной форме:**
 
1. Какие ОС можно выбрать?
   *Одну из 17 ОС на базе Linux*
1. Какие параметры сервера можно выбрать?
   *Диски, вычислительыне ресурсы, сетевые настройки, доступ, метаданные*
1. Какие компоненты мониторинга можно создать?
   *Яндекс мониторниг, Prometeus*
1. Какие системы безопасности предусмотрены?
   межсетевые экраны, антивирусы, VPN решения, фаирвол и др.
1. Как меняется цена от выбранных характеристик? Приведите пример самой дорогой и самой дешёвой конфигурации.
   
![4_chip](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/b31f1ca9-fdaf-4ce3-b284-fda75352932f)



![5_not_chip](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/a8a93f58-0369-42eb-b3a1-66dce26b5dc5)
   

---

## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.
 
---

### Задание 5* 

Выполните действия и приложите скриншот:

1. Создайте виртуальную машину на Yandex Cloud.
1. Создайте сервисный аккаунт.
1. Отсканируйте SSH-ключ.
1. Придумайте логин.
1. Подключитесь к облаку через SSH.
   
![6_vm](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/c4e40b73-353c-4f85-856a-0a9c3c28ae24)

![7_ssh](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/adf25823-9817-43c1-a8c3-3070a0857e05)

![8_info](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/1c8ec200-34a5-472f-ad47-f20b821b0359)



