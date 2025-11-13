output "control_node_info" {
  value = [
    for instance in yandex_compute_instance.control_node : {
      #for instance in  [yandex_compute_instance[1], yandex_compute_instance[1]] : {
      instance_name = instance.name
      external_ip   = instance.network_interface[0].nat_ip_address
      fqdn          = instance.fqdn
    }
  ]
}

output "manage_vm" {
  value = [{
    instance_name = yandex_compute_instance.manage_vm.name
    external_ip   = yandex_compute_instance.manage_vm.network_interface[0].nat_ip_address
    fqdn          = yandex_compute_instance.manage_vm.fqdn
    }
  ]
}