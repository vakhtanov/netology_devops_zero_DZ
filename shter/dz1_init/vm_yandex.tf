terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
     docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
     }
  }
  required_version = ">=1.8.4" 
}

variable "yandex_cloud_token" {
  type = string
  description = "Данная переменная потребует ввести секретный токен в консоли при запуске terraform plan/apply"
}

provider "yandex" {
  token     = var.yandex_cloud_token #секретные данные должны быть в сохранности!! Никогда не выкладывайте токен в публичный доступ.
  cloud_id  = "b1gbnkafeirsgsvi0dtd" #org-wahha
  folder_id = "b1g13qdscue4t6vtbgva" #netology-terraform
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
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
      image_id = "fd8stsue5rim479kphah" #Yandex Cloud Toolbox
      size = 30
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
#  metadata = {
#  ssh-keys = "user:${file("~/.ssh/id_rsa.pub")}"
#  }

}


resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}





