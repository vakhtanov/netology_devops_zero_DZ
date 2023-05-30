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