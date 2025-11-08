output "internal_ip_address_nat_vm" {
  value = yandex_compute_instance.nat.network_interface.0.ip_address
}

output "external_ip_address_nat_vm" {
  value = yandex_compute_instance.nat.network_interface.0.nat_ip_address
}

output "internal_ip_address_public_vm" {
  value = yandex_compute_instance.public.network_interface.0.ip_address
}

output "external_ip_address_public_vm" {
  value = yandex_compute_instance.public.network_interface.0.nat_ip_address
}

output "internal_ip_address_private_vm" {
  value = yandex_compute_instance.private.network_interface.0.ip_address
}

output "external_ip_address_private_vm" {
  value = yandex_compute_instance.private.network_interface.0.nat_ip_address
}

///
//output "external_ip_network_load_balance" {
//   value = flatten([
//    for l in yandex_lb_network_load_balancer.lb-1.listener : [
//      for a in l.external_address_spec : a.address
//    ]
//  ])[0]
  
# value = tolist(yandex_lb_network_load_balancer.lb-1.listener)[0].external_address_spec[0].address
//}
////

output "mysql_address" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host[*].fqdn 
}

output "kuber_cluster_external_v4_endpoint" {
  value = yandex_kubernetes_cluster.netology_regional_cluster.master.0.external_v4_endpoint
}

output "kuber_cluster_external_v4_address" {
  value = yandex_kubernetes_cluster.netology_regional_cluster.master.0.external_v4_address
}