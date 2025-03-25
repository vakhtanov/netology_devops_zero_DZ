
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

variable "host_ip" {
    type = string
  description = "IP адрес созданной машины"
}


provider "docker" {
  host     = "ssh://user@${var.host_ip}:22"
  #ВАЖНО если не в группе !!! sudo usermod -aG docker user
  #host     = "ssh://user@51.250.68.14:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
 
}

  

resource "random_password" "mysql_root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_user_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
  #keep_locally = true
}

resource "docker_container" "mysql" {
  name  = "docker_mysql"
  image = docker_image.mysql.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]

  ports {
    internal = 3306
    external = 3306
    #host_ip  = "127.0.0.1"
  }
}
