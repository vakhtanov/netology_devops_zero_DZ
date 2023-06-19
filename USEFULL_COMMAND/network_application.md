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
![Архитектура netfilter](./pict/firewall_path.JPG)
