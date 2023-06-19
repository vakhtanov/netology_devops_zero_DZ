# Firewall
Эволюция фаирвола ipfwadm (linux 2.0) - ipchains (linux 2.2) - netfilter/iptables  (linux 2.4)

* Руководство по [ipfwadm](http://www.kulichki.com/moshkow/SECURITY/ipfwadm/paper.txt) на английском языке
* Руководство по [ipchains](https://tldp.org/HOWTO/pdf/IPCHAINS-HOWTO.pdf)  на английском и на перевод [русский](https://www.opennet.ru/docs/HOWTO-RU/Ipchains.koi8-r.html)
* Руководство по [iptables](https://www.opennet.ru/docs/RUS/iptables/) (Iptables Tutorial 1.1.19) на русском. [Оригинал](https://github.com/frznlogic/iptables-tutorial) (1.2.2) на английском на GitHub ([здесь](https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html) на одной странице)
* Man [iptables](https://www.opennet.ru/man.shtml?topic=iptables&category=8&russian=0) на русском языке
* [Статья](https://ru.wikibooks.org/wiki/Iptables) в Викиучебнике

## Netfilter - встроен в ядро LInux начиная с вервии 2.4
**Iptables** - специальная утилита для работы с фаирволом Netfilter [iptables](https://ru.wikibooks.org/wiki/Iptables)\
аналог firewalld в операционных системах CentOS, Fedora, OpenSUSE, Red Hat Enterprise Linux, SUSE Linux Enterprise\
![Архитектура netfilter](./pict/firewall_path.JPG)\

![Архитектура netfilter таблицы](./pict/firewall_tables.JPG)

**Iptables** - правила, цепочки, таблицы

цепочки, правила = условие - действие - счетчик

**В зависимоти от адреса пакета он проходит разные таблицы по определенной цепочке**

базовые цепочки: 
* PREROUTING - обрабатывает все входящие пакеты на все интерфейсы, работает до маршрутизации, включая  NAT  и маруировку пакетов. Прохождение таблиц: raw - conntrack - mangle - nat (если пакет не для локальной машины) - другие цепочки
* INPUT - обрабатывает все входящие пакеты адресованные локальной машине. prerouting - mangle - filter - security - nat - local proc
* FORWARD - обрабатываются все пакеты, которые пересылаются дальше. Применяются как к входящему, так и исходящему трафику. Происходит фильтрация трафика prerouting - mangle - filter - security - postrouting
* OUTPUT - исходящие пакеты сгенерированные локальной машиной. local - raw - conntrack - mangle - nat - filter - security - postrouting
* POSTROUTING - окончательная обработка ихсодящиех пакетов, после маршрутизации (исходящих как наружу, так и вовнутрь защищаемой сети) - mangle - nat (если пакет не для локальной машины) - исходящий интерфейс

Таблица iptables — совокупность базовых и пользовательских цепочек, имеющих общее назначение:
* Filter - фильтрация пакетов по IP и порту
* NAT - в заголовке пдменядтся IP адреса и порты
* Mangle  - изменение метаданных пакета
* RAW - действия над сырыми пакетами для обрабокти остальной систмой
* Security-Enhanced Linux (SELinux) — улучшенный механизм управления доступом, который разработало Агентство национальной безопасности США для предотвращения злонамеренных вторжений (можно ввесит ограничения на определеный брацзеи или приложение) - отдельный пакет

IPtables использует систему отслеживания соединений **Conntrack** (англ. отслеживание соединения) — специальная подсистема, отслеживающая состояния соединений и позволяющая использовать эту информацию при принятии решенийо судьбе отдельных пакетов:
* NEW Пакет является первым в соединении
* ESTABLISHED Пакет относится к уже установленному соединению
* INVALID Установить принадлежность пакета не удалось
* RELATED Пакет открывает новое соединение, логически связанное с уже установленными
* UNTRACKED Отслеживание состояния соединения для данного пакета было отключено

Host — любое устройство, подключённое к сети TCP/IP, принимающее или создающее подключения\
Localhost — официально зарезервированное доменное имя для IP-адресов 127.0.0.1/8\
 
