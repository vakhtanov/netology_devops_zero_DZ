terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "yandex_cloud_token" {
  type = string
  description = "Данная переменная потребует ввести секретный токен в консоли при запуске terraform plan/apply"
}

provider "yandex" {
  token     = var.yandex_cloud_token #секретные данные должны быть в сохранности!! Никогда не выкладывайте токен в публичный доступ.
  cloud_id  = "b1gbnkafeirsgsvi0dtd" #org-wahha
  folder_id = "b1gq311m27k0shv7g9gl" #netology-terraform
  zone      = "ru-central1-b"
}

resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "Сервисный аккаунт для управления группой ВМ."
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  #folder_id = "<идентификатор_каталога>"
  folder_id = "${yandex.folder_id}"
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}


resource "yandex_compute_instance_group" "ig-1" {
  name                = "fixed-ig-with-balancer"
  folder_id           = "${yandex.folder_id}"
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = "false"
  instance_template {
    platform_id = "standard-v3"

    scheduling_policy {
      preemptible = true
      }

    resources {
      core_fraction = 20
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8k2ed4jspu35gfde1u" #Ubuntu 24.04 LTS
        size = 15
      }
    }

    network_interface {
      network_id         = "${yandex_vpc_network.network1.id}"
      subnet_ids         = ["${yandex_vpc_subnet.subnet1.id}"]
      #security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
    }

    metadata = {
      #ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
      user-data = "${file("./meta.txt")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

#  allocation_policy {
#    zones = ["ru-central1-a"]
#  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}


#=====================================



resource "yandex_lb_network_load_balancer" "balancer1" {
  name = "balancer1"
  deletion_protection = "false"
  listener {
    name = "my_loadbalance1"
    port = 80
    external_address_spec {
        ip_version = "ipv4"
      }
    }
  attached_target_groupe {
    target_group_id = yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id
    healthcheck {
        name = "http"
        http_options {
          port = 80
          path = "/"
            }
        }
    }
}

resource "yandex_vpc_network" "network1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "loadbalance_ip" {
  value = yandex_lb_network_load_balancer.balancer1.listener
}
output "vm-ips" {
  value = tomap ({
  for name, vm in yandex_compute_instance.vm : network_interface.0.nat_ip_address
  })
}
