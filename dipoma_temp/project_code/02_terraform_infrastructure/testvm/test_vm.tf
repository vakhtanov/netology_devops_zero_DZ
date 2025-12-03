resource "yandex_compute_instance" "test_vm" {
  count = 1 
  #depends_on = [ yandex_compute_instance.for-each ]
  name        = "test-vm"
  hostname    = "test-vm"
  platform_id = var.manage_vm.platform_id
  zone        = var.public_subnet.zone
  #allow_stopping_for_update = true  
  scheduling_policy {
    preemptible = var.manage_vm.preemptible
  }
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204.id
      size     = 20
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