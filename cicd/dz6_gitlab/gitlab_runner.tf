terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "yandex_cloud_token" {
  type        = string
  description = "Данная переменная потребует ввести секретный токен в консоли при запуске terraform plan/apply"
}

provider "yandex" {
  token     = var.yandex_cloud_token #секретные данные должны быть в сохранности!! Никогда не выкладывайте токен в публичный доступ.
  cloud_id  = "b1gbnkafeirsgsvi0dtd" #org-wahha
  folder_id = "b1gq311m27k0shv7g9gl" #netology-terraform
  zone      = "ru-central1-b"
}

#START GITLAB MACHINE
resource "yandex_compute_instance" "cloud-gitlab" {
  name                      = "cloud-gitlab"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = true
  }

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8u159oages5pednfkj" #ubuntu 18, gitlab 16
      size     = 15
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-1.id
    ip_address = "192.168.56.10"
    nat        = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

#START UBUNTU MACHINE
resource "yandex_compute_instance" "ubuntu-runner" {
  name                      = "ubuntu-runner"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = true
  }

  resources {
    core_fraction = 20
    cores         = 4
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd82hhl9107fdlb8ojl1" #ubuntu 18
      size     = 25
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-1.id
    ip_address = "192.168.56.11"
    nat        = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

#  provisioner "remote-exec" {
#    inline = [
#      "export DEBIAN_FRONTEND=noninteractive",
#      "sudo su",
#      "echo now sudo",
#      "sudo apt-get update",
#      "echo now updated",
#      "exit",
 #     "apt-get install -y docker.io docker-compose",
#      "apt-get install -y curl openssh-server ca-certificates tzdata perl",
#      "docker pull gitlab/gitlab-runner:latest",
#      "docker pull sonarsource/sonar-scanner-cli:latest",
#      "docker pull golang:1.17",
#      "docker pull docker:latest",
#    ]
#  }

    connection {
      type        = "ssh"
      user        = "user"
      private_key = file("~/.ssh/id_ed25519")
      host        = self.network_interface[0].nat_ip_address
    }

  provisioner "local-exec" {
     command = <<EOT
    echo "[git_run]" > inventory.ini
    
    for ip in ${self.network_interface[0].nat_ip_address}; do
      echo "$ip ancible_ssh_user=user" >> inventory.ini
    done

    EOT
  }



}


resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.56.0/24"]
}

output "internal_ip_address_cloud-gitlab" {
  value = yandex_compute_instance.cloud-gitlab.network_interface.0.ip_address
}

output "external_ip_address_cloud-gitlab" {
  value = yandex_compute_instance.cloud-gitlab.network_interface.0.nat_ip_address
}


output "internal_ip_address_ubuntu-runner" {
  value = yandex_compute_instance.ubuntu-runner.network_interface.0.ip_address
}
output "external_ip_address_ubuntu-runner" {
  value = yandex_compute_instance.ubuntu-runner.network_interface.0.nat_ip_address
}
