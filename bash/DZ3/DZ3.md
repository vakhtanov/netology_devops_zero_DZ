# Домашнее задание к занятию "Разбор скриптов и и их написание"

### Цель задания
В результате выполнения этого задания вы научитесь:
1. Контролировать передачу пользователем параметров скрипту;
2. Проверять входные данные;
3. Проверять, что скрипт запущен с повышенными привилегиями.
------

### Чеклист готовности к домашнему заданию

1. Установлена операционная система Ubuntu на виртуальную машину или локально и имеется доступ к терминалу (удаленный или из графической оболочки)
2. Установлена утилита arping (sudo apt install -y arping)
3. Просмотрены коды скриптов, расположенные по [ссылке](5-05/)
------

### Задание 1.


Дан скрипт:

```bash
#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi

for SUBNET in {1..255}
do
	for HOST in {1..255}
	do
		echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
	done
done
```


Измените скрипт так, чтобы:

- для ввода пользователем были доступны все параметры. Помимо существующих PREFIX и INTERFACE, сделайте возможность задавать пользователю SUBNET и HOST;
- скрипт должен работать корректно в случае передачи туда только PREFIX и INTERFACE
- скрипт должен сканировать только одну подсеть, если переданы параметры PREFIX, INTERFACE и SUBNET
- скрипт должен сканировать только один IP-адрес, если переданы PREFIX, INTERFACE, SUBNET и HOST
- не забывайте проверять вводимые пользователем параметры с помощью регулярных выражений и знака `~=` в условных операторах 
- проверьте, что скрипт запускается с повышенными привилегиями и сообщите пользователю, если скрипт запускается без них

[Скрипт здесь](scan_ip.sh) или внизу

```bash
#!/bin/bash
if [[ $# = 0 ]]; then
    echo "Usage: sudo $0 PREFIX INTERFACE(192.168) SUBNET(1..255) HOST(1..255)"
    exit 1
fi

trap 'echo "Ping exit (Ctrl-C)"; exit 1' 2

PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET_IN="${3:-NOT_SET}"
HOST_IN="${4:-NOT_SET}"

echo "$PREFIX $INTERFACE $SUBNET_IN $HOST_IN"

username='id -un'
if [[ "$username" -ne 'root' ]]; then
    echo "Start it from root"
    exit 1
fi

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi

scan_hosts (){
    SUBNET="$1"
    for HOST in {1..255}
    do
        echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
        arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
    done
}

if [[ "$SUBNET_IN" = "NOT_SET" ]]; then
    for SUBNET in {1..255}
    do
    scan_hosts "$SUBNET"
    done
elif [[ "$SUBNET_IN" -ge 1 && "$SUBNET_IN" -le 255 ]]; then

        if [[ "$HOST_IN" = "NOT_SET" ]]; then
            scan_hosts "$SUBNET_IN"
        elif [[ "$HOST_IN" -ge 1 && "$HOST_IN" -le 255 ]]; then
            echo "[*] IP : ${PREFIX}.${SUBNET_IN}.${HOST_IN}"
            arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET_IN}.${HOST_IN}" 2> /dev/null
        else
            echo HOST error
            exit 1
        fi
else
    echo SUBNET error
    exit 1
fi 
```

------

## Дополнительные задания (со звездочкой*)

Эти задания дополнительные (не обязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

### Задание 2.

Измените скрипт из Задания 1 так, чтобы:

- единственным параметром для ввода остался сетевой интерфейс;
- определите подсеть и маску с помощью утилиты `ip a` или `ifconfig`
- сканируйте с помощью arping адреса только в этой подсети
- не забывайте проверять в начале работы скрипта, что введенный интерфейс существует 
- воспользуйтесь shellcheck для улучшения качества своего кода


------
