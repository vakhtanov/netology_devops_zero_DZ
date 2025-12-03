terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"

  backend "s3" {
    endpoints = {
    s3 = "https://storage.yandexcloud.net"
    }
    bucket       = "netology-vakhtanov-diploma-state-bucket"
    region       = "ru-central1"
    key          = "terraform.tfstate"
    use_lockfile = true
    #   encrypt = true #Шифрование state сервером Terraform
    #use_path_style            = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.terraform-account-key.json")
}
