variable "yandex_key" {}

source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1g620k1injhaebf3h37"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9bsee8vp1gvp618m4f4"
  token               = var.yandex_key
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    script = "docker_setup.sh"
    
  }

}
