На входе на http сервер ставится **reverse proxy** который может перенаправлять запросы на различные внутренние сервера appache или nginx \
в https сейчас нужно использовать только безопасные протколы  TLS 1.2/1.3 \
комманда для создания самоподписанного сертификата **openssl** \
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt` генерирует ключ и серитфикат \
в конфигурации хранятся ключи открытый ключ и серитфикат (crt)  и закрытый ключ (key) \
если https запрос приходит на сервер его потом можно передать как http (dfload) низкие расходы на шифрование или как https (sslbridge) \
SNI штука для реверс прокси для перенапраления на сервере на нужную страницу