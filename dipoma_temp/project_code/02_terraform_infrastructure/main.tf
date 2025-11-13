resource "yandex_vpc_network" "diloma" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "nodes_subnets" {
  count          = length(var.nodes_subnets)
  name           = var.nodes_subnets[count.index].name
  zone           = var.nodes_subnets[count.index].zone
  network_id     = yandex_vpc_network.diloma.id
  v4_cidr_blocks = var.nodes_subnets[count.index].cidr
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = var.public_subnet.name
  zone           = var.public_subnet.zone
  network_id     = yandex_vpc_network.diloma.id
  v4_cidr_blocks = var.public_subnet.cidr
}

#resource "yandex_vpc_route_table" "route-table" {
#  network_id = yandex_vpc_network.diloma.id
#  static_route {
#    destination_prefix = "0.0.0.0/0"
#    next_hop_address   = var.vm_nat.ip_address
#  }
#}