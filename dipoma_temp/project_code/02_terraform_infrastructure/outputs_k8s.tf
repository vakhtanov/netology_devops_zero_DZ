output "control_node_info" {
  value = [
    for instance in yandex_compute_instance.control_node : {
      #for instance in  [yandex_compute_instance[1], yandex_compute_instance[1]] : {
      instance_name = instance.name
      external_ip   = instance.network_interface[0].nat_ip_address
      fqdn          = instance.fqdn
    }
  ]
  depends_on = [ yandex_compute_instance.control_node ]
}

output "worker_node_info" {
  value = [
    for instance in yandex_compute_instance.worker_node : {
      #for instance in  [yandex_compute_instance[1], yandex_compute_instance[1]] : {
      instance_name = instance.name
      external_ip   = instance.network_interface[0].nat_ip_address
      fqdn          = instance.fqdn
    }
  ]
  depends_on = [ yandex_compute_instance.worker_node ]
}
