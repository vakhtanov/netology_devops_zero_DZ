resource "yandex_compute_instance" "worker_node" {
  count       = var.worker_node.vm_num
  depends_on  = [yandex_compute_instance.control_node]
  name        = "worker-node-${count.index + 1}"
  hostname    = "worker-node-${count.index + 1}"
  platform_id = var.worker_node.platform_id
  allow_stopping_for_update = var.worker_node.allow_stopping_for_update
  zone = var.nodes_subnets[count.index - floor(count.index / length(var.nodes_subnets)) * length(var.nodes_subnets)].zone
  scheduling_policy {
    preemptible = var.worker_node.preemptible
  }
  resources {
    core_fraction = var.worker_node.core_fraction
    cores         = var.worker_node.cpu
    memory        = var.worker_node.ram
  }
  boot_disk {
    initialize_params {
#      image_id = data.yandex_compute_image.ubuntu-2204.id
      image_id = data.yandex_compute_image.rocky.id
      size     = var.worker_node.disk_volume
    }
  }
  
  network_interface {
    #subnet_id = yandex_vpc_subnet.nodes_subnets[worker_node.zone_id].id
    subnet_id = yandex_vpc_subnet.nodes_subnets[count.index - floor(count.index / length(var.nodes_subnets)) * length(var.nodes_subnets)].id

    nat = var.worker_node.nat
    #security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = local.serial-port-enable
    ssh-keys           = local.ssh-keys
  }

}