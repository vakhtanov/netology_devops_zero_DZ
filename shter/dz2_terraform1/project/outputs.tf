output "vm_info" {

  value = [
  for instance in  [yandex_compute_instance.platform, yandex_compute_instance.vm_db_platform] : {
  #for instance in  [yandex_compute_instance[1], yandex_compute_instance[1]] : {
     instance_name = instance.name
     external_ip = instance.network_interface[0].nat_ip_address
     fqdn  = instance.fqdn
    }
  ]
}