resource "yandex_compute_instance" "web" {
  count = var.count_vm.vm_num
  depends_on = [ yandex_compute_instance.for-each ]


  name = "web-${count.index + 1}"
  platform_id = var.count_vm.platform_id
  #allow_stopping_for_update = true
  
  scheduling_policy {
  preemptible = var.count_vm.preemptible
  }
  
  resources {
    core_fraction = var.count_vm.core_fraction
    cores  = var.count_vm.cpu
    memory = var.count_vm.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404.id
      size = var.count_vm.disk_volume
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.count_vm.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }

}