# Обзие свединя про GIT
Установка git из репозитория:\
`sudo apt-get install git`\
Настройка git для корректного отображения автора коммитов:\
`git config --global user.name "My Name"`\
`git config --global user.email myEmail@example.com`\
Инициализация репозитория:\
`git init`
Просмотр текущего статуса:\
`git status`\

## Работа с git:
Чтобы добавить файлы для отслеживания используется команда:\
`git add имя_файла`\
После этого изменения файла начнут отслеживаться и его можно закоммитить:\
`git commit -m "some useful comment here"`
Перед каждым коммитом необходимо проиндексировать файлы, которые будут закоммичены. Это можно сделать с помощью:\
`git add`\
либо добавив ключ:\
` git commit -a`\
Последний коммит в ветке обозначается как HEAD. Это сделано для упрощенного доступа к нему.


Отмена изменений До выполнения индексации:\
`git checkout имя файла`\
После индексации:\
`git reset HEAD имя файла`\
Откат изменений коммита осуществляется с помощью revert:\
`git revert HEAD --no-edit`\
Вместо HEAD можно указать любой id коммита из истории.

Просмотр истории:\
`git log`

## Работа с ветками
Создание веток:\
`git checkout -b имя_ветки`

Слияние веток:\
`git checkout master`
`git merge develop`

Клонировать репозиторий с сервера можно с помощью команды:\
`git clone https://github.com/netology-code/sysadm-homeworks.git`\
Репозиторий будет помещен в директорию ./имя_репозитория

Просмотр удаленных репозиториев:\
`git remote`\
В ответ мы увидим имена всех существующих удаленных репозиториев (по умолчанию обычно origin):\
`git remote show origin`\



Добавление удаленного репозитория:\
`git remote add origin https://github.com/netology-code/sysadm-homeworks.git`\
Отправка изменения в удаленный репозиторий:\
`git push origin master`\
Для того чтобы скачать себе последние изменения из репозитория:\
`git pull`

## .gitignore
```
test.conf
directory/example.conf
cache/*
*.jpg
```
