### Стандартный пароль к VM Windows *Passw0rd!*  
[коробки с операцинными системами](https://www.osboxes.org/ubuntu/)

`sudo apt install mc` - установить коммандер  

### Инфа о системе

`uname -a ` - информация о типе системы и версии ядра
`lsb_release -a` - информация о сборвке и версии
`lscpu` - информация о процессоре
`lshw` - информация об аппаратных ресурсах

`echo $SHELL` - текущая оболочка  
`cat /etc/shells` - установленные оболочки  

`pidof [proc name]` - показывает PID процесса с именем  
`tee` - читает из stdin и напрвляет куда надо  
`$$` - PID текущего процесса  
`id, sudo id` - информация о текущем пользователе  

`type NAME` - тип объекта  
`which NAME` - где исполняемый файл

`w` - действующие сессии терминала  
`whoami` - имя текущего пользователя  
`export NAME=XXXXX` - задать переменную во все дочерние процессы   
`NAME=XXXXX` - задать переменную в текущей оболочке  
`export -n NAME` - удаление переменной  

`lscpu` `cpuinfo` - инфа о проце  

`uname -a или uname -r` - версия ядра
glibc - библиотека для общения с системмнымии вызовами

`wc -l` - счетчик линий  
`wc -w` - счетчик слов  
`wc -m` - счетчик символов  

`file NAME` - показывает тип файла  
`command -v NAME` - показывает что запустит комманда  

### Комманды оболочки

`cat` - 
`less` - постраничный вывод  
`\СИМВОЛ` - экранирование символа он будет использоваться как есть, специальное назначение игнорируется  

### Объединение комманд  
[Справка по объединению](https://housecomputer.ru/os/unix/Operators_combining_teams.html)  
`&` - в конце отправить в фон  
`;` - между коммандами - последовательное выполнение  
`&&` (логическое И) - следующая выполнится только если пердыущая успешно выплнилась - код выхода 0  
`||` (логическое ИЛИ) - следующая выполнится только если пердыущая  выплнилась НЕ УСПЕШНО 

### Фоновые процессы
`ctrl+z` - отправить процесс в фон - он останавливается  
`ctrl+d` - заверщить процесс   
`ctrl+с` - прервать процесс  
`jobs` - процессы в фоне  
`fg %НОМЕР` - переключение на процесс  

`ctrl+l` - очистить экран    
`ctrl+r` - поиск комманд  


### Работа с экранами  
`screen` - запуск экрана  
`exit` - выйти из приложения экранов  
`ctrl+а d ` - пеерключиться на основную сессию bash  
`screen -r` - вернуться в screen  
`reptyr PID` - подключиться к процессу - переместить процесс в текущую сессию  

---

### Работающие процессы

`ps auxf` - процессы и их дерево  
`a` – убирает ограничение о собственных процессах,  
`u` – добавляет расширенный набор часто нужных колонок,  
`x` – убирает ограничение о процессах, запущенных из текущего терминала,  
`w/ww` – убирает ограничение по длине вывода  
`-u` - конкретного пользователя  
`ps ax -o stat --sort=stat` сортировка по статусу  

`echo -n D=; ps -A -o stat | grep D -c` считает количество процессов статуса D  
`pstree -a -p` - дерево процессов  
`lsof` - открытые файлы все  
*флаги*  
`lsof -p XXXX` - открытые файлы конкретного процесса  
`lsof -p $$` - открытые файлы текщей сессии баш  
`lsof -u NAME` - открытые файлы пользователя  
`lsof -U` - открытые файлы сокетов. Сокеты - каналы обмена между процессами - лежат в памяти 
`lsof -c NAME` - файл открытые процессом  
`cat /dev/null > /proc/PID/fd/FD` - обнулить открытый файл PID процесса с FD  
или `echo > /proc/PID/fd/FD`  
`/proc/PID/fd/FD` - конкретный открытый файл  

### vagrant  
`vagrant up` - запустить  
`vagrant suspend` - мягко выключить  
`vagrant halt` - жестко выключить  
`vagrant box add e3801813-59e0-4e69-8ace-78362d9f47cf --name bento/ubuntu20.04`  - добавить образ
`vagrant init bento/ubuntu20.04 `  инициализировать дирректорию  

### Мониторинг системмных вызовов  
`strace` - моинторинг комманды  
*флаги* 
`strace -e KEY` - вывод только конкреных вызовов   
`strace -f ` - вывод дочерних процессов тоже  
`strace -p XXX ` - подключиться к конкретному процессу 
`strace -P XXX ` - системмные вызовы определенного пути  
`pidof NAME` - PID процесса с именем  
`strace -f sh -c ls` - следить за вызовами ls в sh  
`strace -f sh -c ls` `-c` - передать в sh комманду ls  
`strace -f bash -c 'cd /tmp'`  
`strace -s 65000` - вывести полные строки - по умолчанию 32 байта   
`strace -y` - аннотации к фаловым дискрипторам   
`strace -e openat` - фильтр по вызову    
 
 #### Выводы starce  
 openat - открывает файл и присваивает дескриптор  
 read - читает данные  
 close(3) - закрывает файл  
 write - пишет в файл  
 stat - пытается вызвать файл по переданному пути  

### Работа с руководством  
 *В руководстве много разделов и все они сразу не показываются, в документации есть ссылк ина них, например `man(2)`, ссылка на второй раздел*
`man NAME` - поиск справки по комманде  
`man bash` - справка по встроенным коммандам  
`man N NAME` - поиск справки по комманде в разделе N  
`man 7 man`  
`man -f man` - показать все разделы по комманде  
`man -k printf` - поиск комманд где есть `prinf`  
`man -k 'user ' | grep password` - поиск по комманде user где в тексте есть password  
*Поиск внутри руководства - нажимаем `/` пишем слово. Вперед - `n`, назад `N`*  
*Поиск внутри руководства - нажимаем `&` пишем слово. Все лишние строки скрываются,*  
*Внутри руководства нажимаем `-N` enter - показваюстя номера строки*  
*Внутри руководства нажимаем `-n` enter - убрать номера строки*  
*Внутри руководства нажимаем `234g` перейти на 234 строку*  

### Работа с SET  
 *меняет режимы работы bash*  
`set` - текущие настройки    
`set -euxo pipefail` хорошо было бы использовать в сценариях - при ошибках обращения и выполнения - скрипт немедленно завершается и выполняется трассировка  


### Работа с Test 
 *проверяет типы фалов и сравнивает значения*  
`test -d DIR` - существует ли путь и является ли дирректорией  
`test -e FILE` - существует ли файл  

### Работа с GREP  
`grep WHAT FILE` - поиск чегото в файл  
`-c` - подсчитать количество вхождений  

### Работа с системой   
`free -m` - использование памяти  
`echo 3 >/proc/sys/vm/drop_caches` - очистить кеш устройств  
`top` - монитор ресурсов, `shift+f` - управление  
`htop` - современный вариант top  
`atop` - запись в файл  
`iotop`  
`iftop`  


### Работа с KILL   
`kill -HUP $(cat /var/run/nginx.pid)` - Нередко HUP командует процессу перечитать свои конфигура  
kill dash nine - завершить по коду 9 - полностью преррвать  
обычно надо по коду 15! - штатное завершение  

```
Список полезной литературы  
«Unix и Linux: Руководство системного администратора», Эви Немет, Гарт Снайдер, Трент Хейн, Бен Уэйли, Дэн Макни.  
«TCP/IP. Сетевое администрирование», Хант Крэйг.  
«Компьютерные сети. Принципы, технологии, протоколы», Олифер Виктор Григорьевич, Олифер Наталия Алексеевна.  
«Компьютерные сети», Эндрю Таненбаум, Дэвид Уэзеролл.  
«Современные операционные системы», Эндрю Таненбаум, Херберт Бос.  
«Архитектура компьютера», Эндрю Таненбаум, Тодд Остин.  
«Установка, настройка, администрирование», Михаэль Кофлер.  
«Удалённый сервер своими руками. От азов создания до практической работы», Николай Левицкий.  
«Внутреннее устройство Linux», Брайан Уорд.  
«Администрирование сетей Cisco: освоение за месяц», Пайпер Б.  
«Сценарии командной оболочки. Linux, OS X и Unix». Серия «Для профессионалов».  
«Penetration Testing with the Bash shell», Keith Makan.  
«Pro Bash Programming Scripting the GNU/Linux Shell», Chris F. A. Johnson, Jayant Varma.  
```