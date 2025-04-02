resource "yandex_compute_instance" "web" {
  count = 2
  depends_on = [ yandex_compute_instance.for-each ]


  name = "web-${count.index + 1}"
  platform_id = "standard-v3"
  #allow_stopping_for_update = true
  
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
      image_id = "fd8r7e7939o13595bpef" #Ubuntu 22.04 LTS OS Login
      size = 30
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }

}