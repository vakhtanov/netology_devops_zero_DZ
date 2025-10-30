resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet.subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_subnet.cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet.subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_subnet.cidr
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_route_table" "route-table" {
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.vm_nat.ip_address
  }
}