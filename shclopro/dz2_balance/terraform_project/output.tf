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

#output "external_ip_load_balance" {
#  value = yandex_lb_network_load_balancer.lb-1.listener[0].external_address_spec[0].address
#}
