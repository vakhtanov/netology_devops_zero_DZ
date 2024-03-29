#Инфраструктура как код (IaC)

**IaC** — модель, по которой процесс настройки инфраструктуры
аналогичен процессу программирования ПО.
Приложения могут содержать скрипты, которые создают свои
собственные виртуальные машины и управляют ими.
Это основа облачных вычислений и неотъемлемая часть DevOps

**HCL** — это язык программирования, разработанный HashiCorp. Он в
основном используется DevOps. Представляет собой
методологию разработки, предназначенную для ускорения
процесса кодирования. HCL используется для настройки
программных сред и программных библиотек.
HCL совместим с JSON благодаря API HCL. Его дизайн и синтаксис
более читабельны.

Синтаксис и описание [HCL](https://www.terraform.io/docs/language/index.html)

Основные игроки:
* [Vagrant](https://www.vagrantup.com/)
* [Ansible](https://www.ansible.com/)
* [Packer](https://www.packer.io/)
* [Terraform](https://www.hashicorp.com/products/terraform)
* [SaltStack](https://saltproject.io/)
* [Chef](https://www.chef.io/products/chef-infra)

## Terraform
Terraform — это программный инструмент с открытым исходным
кодом, созданный HashiCorp, который помогает управлять
инфраструктурой. Пользователи определяют и предоставляют
инфраструктуру центра обработки данных с помощью
декларативного языка конфигурации, известного как язык
конфигурации HashiCorp (HCL) или, необязательно, JSON.

Terraform - для облаков. Создает не изменяемую архитектуру

* оркестрирование, а не просто конфигурация инфраструктуры;
* построение неизменяемой инфраструктуры;
* декларативный, а не процедурный код;
* архитектура, работающая на стороне клиента (комманды подаются со стороны клиента)

Декларативный подход - то, что требуется получить (терраформ, салт, паппет)\
процедурный - описывает шаги для достижения результата (чиф, ансибл)

**недостатки** (ошибки в ПО, описывать инфраструтуру должен один человек с одного терминала для исключения неоднознатчностей, работает только там где есть собственное API)

**ПРовайдеры облаков**
Пчелайн
VK облако
МТС облако

**Преимущества** одна утилита и один язык - не зависимо от провайдера, простота полноценного запуска приложений и управления

## Установка Terraform

[тераформ оффишел](https://www.terraform.io/downloads.html)
Через VPN:
1) Установка через repository git `cd /usr/local/src && git clone https://github.com/hashicorp/terraform.git'
2) Вручную `cd /usr/local/src && curl -O https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_arm.zip`   
4) Установка через repository apt
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
```

### Установка от яндекса
[тераформ от Яндекса](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart)
Необходимо скачать тераформ и распаковать в `/usr/local/bin` - папка прописана в PATH - там могут лежать программы, для удобного запуска

`zcat TERRAFORM123 > terraform`\
включаем возможность запуска\
`chmod 744 terraform`\
`export PATH=$PATH:/path/to/terraform` - включаем запуск 

В домашней папке проекта создайте файл ресурсов `.terraformrc` и добавьте блок (**Linux**)
```HCL
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
**Windows** - Откройте файл конфигурации Terraform CLI terraform.rc в папке %APPDATA% вашего пользователя.

создайте папку проекта и там конфигурационный файл `*.tf`, напрмер main.tf и добавьте блоки:
```HCL
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "<зона доступности по умолчанию>"
}
```
* source — глобальный адрес источника  провайдера.
* required_version — минимальная версия Terraform, с которой совместим провайдер.
* provider — название провайдера.
* zone — зона доступности, в которой по умолчанию будут создаваться все облачные ресурсы.

В папке проекта `terraform init` - скачивает API провайдера и готовит к работе с облаками

минимальный набор переменных для подключения к провайдеру
```
provider "Имя провайдера" {
user = "ваш_логин"
password = "ваш_пароль"
org = "название_организации"
url = "название сайта с api "
}
```

[Пример кода Terraform для развертывания кластера автомасштабирования](https://github.com/wallarm/terraform-example.git)

# Синтаксис Terraform
Однострочные комментарии начинаются с #
* Многострочные комментарии заключаются в символы /* и */
* Значения присваиваются с помощью синтаксиса key = value (пробелы не имеют значения). Значение может быть любым
примитивом (строка, число, логическое значение), списком или картой.
* Строки в двойных кавычках.
* Строки могут интерполировать другие значения, используя синтаксис, заключенный в ${} , например ${var.foo} .
Многострочные конструкции могут использовать синтаксис «здесь, документ» в стиле оболочки, при этом строка
начинается с маркера типа <<EOF , а затем строка заканчивается на EOF в отдельной строке. Строки и конечный маркер не должны иметь отступа.
* Предполагается, что числа имеют основание 10. Если вы поставите перед числом префикс 0x , оно будет рассматриваться как шестнадцатеричное число.
* Логические значения: true , false .
* Списки примитивных типов можно составлять с помощью квадратных скобок ( [] ). Пример: ["foo", "bar", "baz"] .
* Карты могут быть сделаны с фигурными скобками ( {} ) и двоеточие ( : ): { "foo": "bar", "bar": "baz" } . Кавычки могут быть
опущены на ключах, если ключ не начинается с числа, и в этом случае кавычки требуются. Для однострочных карт
необходимы запятые между парами ключ/значение. В многострочных картах достаточно новой строки между парами ключ/значение.

**Переменные User string**\
var. префикс, за которым следует имя переменной. Например,
${var.foo} интерполирует значение переменной foo .

**Переменные карты пользователя**\
Синтаксис: var.MAP["KEY"] . Например, ${var.amis["us-east-1"]}
получит значение ключа us-east-1 в переменной карты amis .

**Переменные списка пользователей**\
Синтаксис: "${var.LIST}" . Например, "${var.subnets}" получит
значение списка subnets в виде списка. А также может
возвращать элементы списка по индексу: ${var.subnets[idx]} 

**Условные операторы троичная операция:**\
`CONDITION ? TRUEVAL : FALSEVAL`
Пример:
```HCL
resource "aws_instance" "web" {
subnet = "${var.env == "production" ? var.prod_subnet : var.dev_subnet}"
}
```

**Поддерживаемые операторы:**
Равенство: == и !=\
Численное сравнение: > , < , >= , <=\
Логическая логика: && , || , одинарный !\

**Математика :**
Поддерживаемые операции:
Сложение ( + ), вычитание ( - ), умножение ( * ) и деление ( / ) для типов с плавающей запятой.\
Сложение ( + ), Вычитание ( - ), Умножение ( * ), Разделение ( / ) и Помодулю ( % ) для целочисленных типов.\
Приоритеты операторов — это стандартный математический порядок операций: умножение ( * ), деление ( / ) и модуль ( % ) имеют
приоритет над сложением ( + ) и вычитанием ( - ). Круглые скобки могут использоваться для принудительного упорядочивания.

Пример использования математических операций:
```HCL
"${2 * 4 + 3 * 3}" # computes to 17
"${3 * 3 + 2 * 4}" # computes to 17
"${2 * (4 + 3) * 3}" # computes to 42
```

**Инструменты:**\
[Шаблоны](https://www.terraform.io/docs/language/expressions/strings.html)\
[Встроенные функции](https://habr.com/ru/post/538660/)

Пример синтаксиса\
![image](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/4a553707-202b-45ec-a3d7-faf94172bcf4)

также поддеживается JSON




