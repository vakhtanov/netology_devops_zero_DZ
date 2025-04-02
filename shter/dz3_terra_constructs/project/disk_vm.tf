resource "yandex_compute_disk" "storage" {
  count = 3
  name = "storage${count.index}"
  size = 1
}

resource "yandex_compute_instance" "storage" {

  name = "storage"
  platform_id = "standard-v3"
  
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage
    #for_each = {for item in var.each_vm : item.vm_name => item}
    content {
      disk_id  = secondary_disk.value.id
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