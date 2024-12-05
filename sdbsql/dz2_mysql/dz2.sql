CREATE USER 'sys_temp'@'%' IDENTIFIED BY 'parol';

SELECT User,Host FROM mysql.user;

GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'%';

SHOW GRANTS FOR 'sys_temp'@'%';

ALTER USER 'sys_temp'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';