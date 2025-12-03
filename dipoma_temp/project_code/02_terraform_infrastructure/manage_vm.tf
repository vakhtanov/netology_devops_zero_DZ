

resource "yandex_compute_instance" "manage_vm" {
  count = var.manage_vm.create_vm ? 1 : 0 
  #depends_on = [ yandex_compute_instance.for-each ]
  name        = "manage-vm"
  hostname    = "manage-vm"
  platform_id = var.manage_vm.platform_id
  zone        = var.public_subnet.zone
  #allow_stopping_for_update = true  
  scheduling_policy {
    preemptible = var.manage_vm.preemptible
  }
  resources {
    core_fraction = var.manage_vm.core_fraction
    cores         = var.manage_vm.cpu
    memory        = var.manage_vm.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204.id
      size     = var.manage_vm.disk_volume
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = var.manage_vm.nat
    #security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}