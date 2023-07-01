**Настройка Router 0**
*Настройка ISAKMP (IKE) - ISAKMP Phase 1*
```
crypto isakmp policy 1
encr 3des
hash md5
authentication pre-share
group 2
lifetime 86400
```

*Pre-Shared ключ для аутентификации с нашим партнером*

```
crypto isakmp key NETOLOGY address 188.144.0.2
```

*Нужно создать расширенный acceess list*
```
ip access-list extended STD-VPN
permit ip 192.168.1.0 0.0.0.255 192.168.0.0 0.0.0.255
```

*Настройка IPSec*
* Создаем IPSec Transform*
```
crypto ipsec transform-set NET-TS esp-3des esp-md5-hmac
```

*Создаем Crypto Map*
```
crypto map CNET-MAP 10 ipsec-isakmp
set peer 188.144.0.2
set transform-set NET-TS
match address STD-VPN
```

*Применяем криптографическую карту к общедоступному интерфейсу*
interface Gi0/0/0
crypto map CNET-MAP


```
ip access-list extended STD-NAT
deny ip 192.168.1.0 0.0.0.255 192.168.0.0 0.0.0.255
permit ip 192.168.1.0 0.0.0.255 any
```


**Настройка Router 1**\
*Настройка ISAKMP (IKE) - ISAKMP Phase 1*
```
crypto isakmp policy 1
encr 3des
hash md5
authentication pre-share
group 2
lifetime 86400
```

*Pre-Shared ключ для аутентификации с нашим партнером*

```
crypto isakmp key NETOLOGY address 87.250.0.2
```

*Нужно создать расширенный acceess list*
```
ip access-list extended STD-VPN
permit ip 192.168.0.0 0.0.0.255 192.168.1.0 0.0.0.255
```

*Настройка IPSec*
* Создаем IPSec Transform*
```
crypto ipsec transform-set NET-TS esp-3des esp-md5-hmac
```

*Создаем Crypto Map*
```
crypto map CNET-MAP 10 ipsec-isakmp
set peer 87.250.0.2
set transform-set NET-TS
match address STD-VPN
```

*Применяем криптографическую карту к общедоступному интерфейсу*
interface Gi0/0/0
crypto map CNET-MAP

```
ip access-list extended STD-NAT
deny ip 192.168.0.0 0.0.0.255 192.168.1.0 0.0.0.255
permit ip 192.168.0.0 0.0.0.255 any
```
