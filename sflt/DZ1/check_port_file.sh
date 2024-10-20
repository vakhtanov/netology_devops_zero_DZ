#!/bin/bash

# Параметры
SERVER="localhost"  
PORT=80             
INDEX_FILE="/var/www/html/index.nginx-debian.html"  

# Проверка доступности порта
if ! nc -z $SERVER $PORT; then
    echo "Порт $PORT на сервере $SERVER недоступен."
    exit 1
fi

# Проверка существования файла index.html
if ! [ -f "$INDEX_FILE" ]; then
    echo "Файл $INDEX_FILE не найден."
    exit 1
fi

echo "Проверка завершена успешно."
exit 0  