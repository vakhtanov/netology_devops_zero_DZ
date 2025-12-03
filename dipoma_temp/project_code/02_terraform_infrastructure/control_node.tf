resource "yandex_compute_instance" "control_node" {
  count = length(var.nodes_subnets)
  #depends_on = [ yandex_compute_instance.for-each ]
  name        = "control-node-${var.nodes_subnets[count.index].name}"
  hostname    = "control-node-${var.nodes_subnets[count.index].name}"
  platform_id = var.control_node.platform_id
  zone        = var.nodes_subnets[count.index].zone
  allow_stopping_for_update = var.control_node.allow_stopping_for_update  
  scheduling_policy {
    preemptible = var.control_node.preemptible
  }
  resources {
    core_fraction = var.control_node.core_fraction
    cores         = var.control_node.cpu
    memory        = var.control_node.ram
  }
  boot_disk {
    initialize_params {
#      image_id = data.yandex_compute_image.ubuntu-2204.id
      image_id = data.yandex_compute_image.rocky.id
      size     = var.control_node.disk_volume
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.nodes_subnets[count.index].id
    nat       = var.control_node.nat
    #security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}