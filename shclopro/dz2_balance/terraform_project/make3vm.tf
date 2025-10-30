
resource "yandex_compute_instance" "nat" {
  name = var.vm_nat.name
  platform_id = var.vm_nat.platform_id
  hostname = var.vm_nat.name
  #allow_stopping_for_update = true
  
  scheduling_policy {
  preemptible = var.vm_nat.preemptible
  }  
  resources {
    cores  = var.vm_nat.cpu
    memory = var.vm_nat.ram  
    core_fraction = var.vm_nat.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vm_nat.image_id
      size = var.vm_nat.disk_volume
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = var.vm_nat.ip_address
    nat       = true
  }  
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}

resource "yandex_compute_instance" "public" {
  name = var.vm_public.name
  hostname = var.vm_public.name
  platform_id = var.vm_public.platform_id

  scheduling_policy {
  preemptible = var.vm_public.preemptible
  }  
  resources {
    cores  = var.vm_public.cpu
    memory = var.vm_public.ram  
    core_fraction = var.vm_public.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vm_public.disk_volume
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }  
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}

resource "yandex_compute_instance" "private" {
  name = var.vm_private.name
  hostname = var.vm_private.name
  platform_id = var.vm_private.platform_id
  #allow_stopping_for_update = true
  
  scheduling_policy {
  preemptible = var.vm_private.preemptible
  }  
  resources {
    cores  = var.vm_private.cpu
    memory = var.vm_private.ram  
    core_fraction = var.vm_private.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vm_private.disk_volume
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }  
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}