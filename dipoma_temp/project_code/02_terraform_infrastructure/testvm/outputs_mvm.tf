
output "manage_vm" {
  value = [
    for instance in yandex_compute_instance.worker_node : {
    instance_name = instance.name
    external_ip   = instance.network_interface[0].nat_ip_address
    fqdn          = instance.fqdn
    }
  ]
  depends_on = [ yandex_compute_instance.manage_vm ]
}