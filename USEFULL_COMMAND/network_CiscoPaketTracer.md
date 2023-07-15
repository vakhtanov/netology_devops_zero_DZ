# Практика по сетям
В рамках курса используется Cisco Packet Tracer. Есть аналоги:
* GNS3
* EVE-NG
* Boson NetSim
* Huawei eNSP

## Комманды CPT
`en` - привелегированный доступ\
`config t` - переход в режим конфигурации\
`vlan 10` - делаем vlan 10 и переходим в режим ее редактирвоания\
`name 10` - задаем ей имя\
`exit` - в данном случае выходим из влан 10 в обычный конфиг\
` do wr` - запись настроек в долговременную память, для сохранения после перезагрузки

### присвоим влан порту
`interface fastEthernet 0/1` - переходим в интерфейс\
`switchport mode access` - переключает порт в режим access (не обязательно)\
`switchport access vlan 10` - присваиваем порту доступ к vlan 10\
`exit` - в данном случае выходим из интерфецса в обычный конфиг\


в режиме `config` переключиться на интерфейс\
`interface gigabitEthernet 0/1`\
`switchport mode trunk` - переключить порт в режим trunk - для проброса всех Vnal

**vlan должен быть прописан на всех коммутаторах нужых**

### настройка роутера
`en`\
`config t`\
`interface gigabitEthernet 0/0/0.10` - создать саб интерфейс - виртуаьный на физическом `gigabitEthernet 0/0/0`\
`encapsulation dot1Q 10` - сделать энкапсуляцию в 10 vlan по точке (подключения?)\
`ip address 192.168.10.1 255.255.255.0` - присвоить ip данному интерфейсу\
`interface gigabitEthernet 0/0/0` - пеерйти в физический интерфейс\
`no shutdown` - активировать сам физический интерфейс\
`ip route 192.168.10.0 255.255.255.0 10.0.0.1` - маршрут Запросы в какую сеть - на какой ip отправлять

### настройка роутера подключения и безопасности
`hostname ...`\
`ip domain-name ...`\
`username admin secret admin` - шифрование сесии с ключем admin - проверка:
#### настройка удаленного подключения
`line vty 0 15` - виртуальыне лини подключения от 0 до 15\
`login local` - ? \
`enable secret cisco` - задать пароль **cisco**\
`crypto key generate rsa` - сгенерировать ключ, шифровать сессию 2048\
`service password-encryption` - шифрование пароля\

`show run` - проверка параметров подключения\
[ПРИМЕР СЕТИ](task1.pkt)

[Статья по IP адреса и маски](https://habr.com/ru/articles/350878/)

### Настройка NAT 
[Руководство по настройкеъ(https://caexpert.ru/laboratornaya-rabota-8-cisco-packet-tracer-nastrojka-nat.html)
`en` - привелегии\
`config t` - режим конфиграции\
**Определяем входной и выходной интерфейс**\
`int NAME (fa0/0)` - переключаемся на интерфейс\
`ip nat outside` - внешний\
`exit`\
`int NAME (fa0/1.1)`- переключаемся на интерфейс\
`ip nat inside` - внутренний\
`exit`\
**ACCESS LIST** - какие сети натим\
в корне конфига\
`ip access-list standart NAME` - создаем список доступа\
`permit 192.168.2.0 0.0.0.255` - добавляем в него сети\
`permit IP WILDCARD` - шаблон добавления\
**(PAT) port address translation**\
`ip nat inside source list NAME interface fastEthernet0/0 overload` - включаем нат: изнутри, для списка через определенынй порт, overload - режим PAT\
`end`\
`show ip nat translation` - показать таблицу трансляции\

`show access-lists` - показать списки доступа с номерами сторк\
в корне конфига\
`ip access-list standart NAME` - создаем список доступа\
`no 10` - удалить 10 строку

**(SNAT) static network address translation**\
в корне конфига\
`ip nat inside source static tcp INNER_IP INNER_PORT OUTER_IP OUTER_PORT ` -включаем статический нат: для публикации сервиса в интернете

### Настройка VPN
[руководство](https://wiki.merionet.ru/articles/nastrojka-site-to-site-ipsec-vpn-na-cisco)\
#### Настройка ISAKMP Phase 1
На маршрутизаторе главного офиса настройте политики ISAKMP:
```
R1(config)#  crypto isakmp policy 1
R1(config-isakmp)# encr 3des - метод шифрования
R1(config-isakmp)# hash md5 - алгоритм хеширования
R1(config-isakmp)# authentication pre-share - использование предварительного общего ключа (PSK) в качестве метода проверки подлинности
R1(config-isakmp)# group 2 - группа Диффи-Хеллмана, которая будет использоваться
R1(config-isakmp)# lifetime 86400 - время жизни ключа сеанса
```
**Pre-Shared** ключ\
`crypto isakmp key <КЛЮЧ> address <АДРЕС ВТОРОЙ ТОЧКИ>` -  **Pre-Shared** ключ для аутентификации с маршрутизатором филиала.


#### Расширенный access list - созается для гибкого задания адресов доступа, нужен обязательно
```
R1(config)# ip access-list extended <НАЗВАНИЕ>
R1(config-ext-nacl)# permit ip <SOURCE-IP /WILDCARD> <DEST-IP /WILDCARD>
```
#### Пример расширенного access list для разделения NAT (для интернета) и VPN
```
R1(config)# ip nat inside source list 100 interface fastethernet0/1 overload
R1(config)# access-list 100 deny ip 10.10.10.0 0.0.0.255 20.20.20.0 0.0.0.255
R1(config)# access-list 100 permit ip 10.10.10.0 0.0.0.255 any
```
#### Настройка IPsec
Создайте набор преобразования (Transform Set), используемого для защиты наших данных.\
*crypto ipsec transform-set <название> esp-3des esp-md5-hmac*\

#### Cryptomap
Создайте крипто-карту с указанием внешнего ip-адреса интерфейса и привяжите его к интерфейсу.
```
R1(config)# crypto map <название> 10 ipsec-isakmp
R1(config-crypto-map)# set peer </ip-address ВНУТРЕННИЙ>
R1(config-crypto-map)# set transform-set <название>
R1(config-crypto-map)# match address <название access-листа>
```
#### Присвоим интерфейсе Cryptomap
```
R1(config) interface <ИМЯ Интерфейса>
R1(config- if)# crypto map <название крипто-карты>
```
#### Отключить NAT для внутрених адесов через список список NAT
```
access-list 100 deny ip 10.10.10.0 0.0.0.255 20.20.20.0 0.0.0.255
access-list 100 deny ip 10.10.10.0 0.0.0.255 20.20.20.0 0.0.0.255
```
