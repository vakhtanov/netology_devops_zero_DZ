## OpenStack - ПО для создания частных облаков - оболочка гипервизора
ставится через shap (новый менеджер пакетов, где все пакеты основные и зависимости упакованы в дистрибутив)\
[openstack help](https://ruvds.com/ru/helpcenter/openstack-ubuntu-20-04/)

![image](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/fc151564-e110-43b1-9ff2-4de7681a7584)

`service nginx reload`

## Программы для виртуализации
ESXi, ProxMox, OpenNebula, HyperV, KVM, Xen - гипервизоры

# типы гипервизоров
Тип 1. Автономный гипервизор. (VMware ESXi)\
Тип 2. Гипервизор под управлением хостовой ОС (Oracle VirtualBox, VMware Workstation, Parallels Desktop)\
Тип 3. Гибридный гипервизор (Microsoft HyperV, XEN, KVM)

## технологии виртуализации:
VT-x, VT-d (Intel);\
AMD-V (AMD);\
EL2 (ARM).\

## среды виртуализации
Libvirt — это open-source набор инструментов, который предоставляет унифицированный и абстрактный интерфейс для взаимодействия с гипервизорами и системами виртуализации, включая KVM, Xen, VMware и другие.
