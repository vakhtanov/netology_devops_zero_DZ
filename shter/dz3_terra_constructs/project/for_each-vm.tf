resource "yandex_compute_instance" "for-each" {
  for_each =  {for item in var.each_vm : item.vm_name => item}

  #depends_on = [  ]


  name = each.value.vm_name
  platform_id = each.value.platform_id
  #allow_stopping_for_update = true
  
  scheduling_policy {
  preemptible = each.value.preemptible
  }
  
  resources {
    core_fraction = each.value.core_fraction
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = each.value.image_id #Ubuntu 22.04 LTS OS Login
      size = each.value.disk_volume
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