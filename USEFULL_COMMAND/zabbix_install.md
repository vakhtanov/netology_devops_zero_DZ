` sudo -s`  \
` wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb`  зависит от версии берем с сайта  \
` dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb`  \
` apt update`\
`apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent`  \
`sudo -u postgres createuser --pwprompt zabbix`\
для автоматизации `su - postgres c 'psql --command CREATE USER zabbix WITH PASSWORD '\'123456789\'';"' ` \
`sudo -u postgres createdb -O zabbix zabbix`\
для автоматизации `su - postgres -c 'psql --command "CREATE DATABASE zabbix OWNER zabbix;"' `\
Отредактируйте файл /etc/zabbix/zabbix_server.conf\
DBPassword=password\
`systemctl restart zabbix-server zabbix-agent apache2`\
`ystemctl enable zabbix-server zabbix-agent apache2`\
The default URL for Zabbix UI when using Apache web server is http://host/zabbix
