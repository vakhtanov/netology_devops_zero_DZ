terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

#variable "yandex_cloud_token" {
#  type = string
#  description = "Данная переменная потребует ввести секретный токен в консоли при запуске terraform plan/apply"
#}

provider "yandex" {
  #token     = var.yandex_cloud_token #секретные данные должны быть в сохранности!! Никогда не выкладывайте токен в публичный доступ.
  token     = "${file("yandexx.key")}"
  cloud_id  = "b1gbnkafeirsgsvi0dtd" #org-wahha
  folder_id = "b1gq311m27k0shv7g9gl" #netology-terraform
  zone      = "ru-central1-b"
}

resource "yandex_compute_instance" "vm" {
  count = 2
  name = "vm${count.index}"
  platform_id = "standard-v3"
  allow_stopping_for_update = true
  
  scheduling_policy {
  preemptible = true
  }
  

  
  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd874d4jo8jbroqs6d7i"
      size = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }
  

#  metadata = {
#  ssh-keys = "user:${file("~/.ssh/id_rsa.pub")}"
#  }

  metadata = { 
  user-data = "${file("cloud_init.yml")}" 
  }

}


resource "yandex_lb_target_group" "group1" {
  name = "group1"

# В замен этой группы - dynamic
#  target {
#    subnet_id = yandex_vpc_subnet.subnet-1.id 
#    address = yandex_compute_instance.vm[0].network_interface.0.ip_address
#  }

  dynamic "target" {
    for_each = yandex_compute_instance.vm
    content {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        address = target.value.network_interface.0.ip_address
        }
    }
}

resource "yandex_lb_network_load_balancer" "balancer1" {
  name = "balancer1"
  deletion_protection = "false"
  listener {
    name = "my-loadbalance1"
    port = 80
    external_address_spec {
        ip_version = "ipv4"
      }
    }
  attached_target_groupe {
    target_group_id = yandex_lb_target_group.group1.id
    healthcheck {
        name = "http"
        http_options {
          port = 80
          path = "/"
            }
        }
    }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "loadbalance_ip" {
  value = yandex_lb_network_load_balancer.balancer1.listener
}
output "vm-ips" {
  value = tomap ({
    for name, vm in yandex_compute_instance.vm : name => vm.network_interface.0.nat_ip_address
  })
}
