# Troubleshooting

Траблшутинг (troubleshooting) — форма решения проблем, часто применяемая к ремонту неработающих устройств или процессов
![01logic.JPG](./pict/01logic.JPG)
![02troble1.JPG](./pict/02troble1.JPG)
![02troble2](./pict/02troble2.JPG)\
Рекомендации:
* Попробовать подключение с другого оператора(4G-роутера, резервного канала и т. д.)
* Выяснить у сетевого администратора или коллег, не были ли внесены изменения в конфигурационные файлы

![04main_trobels.JPG](./pict/04main_trobels.JPG)
![05locate_troble.JPG](./pict/05locate_troble.JPG)
Л — логика. Л — локализация проблемы:
* Если один клиент жалуется на отсутствие доступа к разным сервисам, скорее всего, проблема только у него (  компьютер, IP-адрес, сеть, ПО
* Если много клиентов жалуется на отсутствие доступа к одному сервису — скорее всего, проблема в сервисе
* Если много клиентов жалуется на отсутствие доступа к разным сервисам — скорее всего, это или глобальные проблемы в локальной сети, или проблемы у провайдера

## Проблемы L1,L2
Физические проблемы. Вопросы, на которые нужно иметь положительный ответ:\
Есть ли электричество на оборудовании? Включена ли VM? Подключён ли кабель? Если подключён, уверены ли вы, что он целый?\
Проблемы с connectivity (L1, L2) Вопросы, на которые нужно иметь положительный ответ:\
Если кабель подключён и в порядке — горит ли лампочка (есть ли «линк»)? Не заблокирован ли порт в настройках коммутатора/сервера? Не заблокирован ли MAC-адрес на коммутаторе?

![06troble_l12.JPG](./pict/06troble_l12.JPG)

## Проблемы L1,L2,L3,L4
![07l234_troble.JPG](./pict/07l234_troble.JPG)
![08L2_arp.JPG](./pict/08L2_arp.JPG)
![09L2_tcpdaump.JPG](./pict/09L2_tcpdaump.JPG)
![10aL3_ip_addr.JPG](./pict/10aL3_ip_addr.JPG)
![10L3_iproute.JPG](./pict/10L3_iproute.JPG)
![11L3_ping.JPG](./pict/11L3_ping.JPG)
![12L3_ping2.JPG](./pict/12L3_ping2.JPG)
![13L3_ping3.JPG](./pict/13L3_ping3.JPG)
![14_L3_iproute.JPG](./pict/14_L3_iproute.JPG)

## DNS
![15_DNS.JPG](./pict/15_DNS.JPG)

**Настройка DNS в ОС Linux:**
[Link1](https://tokmakov.msk.ru/blog/item/522)\
[Link2](https://itgap.ru/post/lokalnyj-dns-server-na-linux)

![](./pic/)
![](./pic/)


