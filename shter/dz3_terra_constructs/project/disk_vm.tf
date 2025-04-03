resource "yandex_compute_disk" "storage" {
  count = var.storage.s_disk_count
  name = "storage${count.index}"
  size = var.storage.s_disk_size
}

resource "yandex_compute_instance" "storage" {

  name = var.storage.vm_name
  platform_id = var.storage.platform_id
  
  scheduling_policy {
  preemptible = var.storage.preemptible
  }
  
  resources {
    core_fraction = var.storage.core_fraction
    cores  = var.storage.cpu
    memory = var.storage.ram
  }

  boot_disk {
    initialize_params {
      image_id = var.storage.image_id
      size = var.storage.disk_volume
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
    nat       = var.storage.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }

}