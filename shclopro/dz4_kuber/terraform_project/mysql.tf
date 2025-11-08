//
// Create a new MDB High Availability MySQL Cluster.
//
resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.develop.id
  version     = "8.0"
  deletion_protection = true

////

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  maintenance_window {
     type = "ANYTIME"
  }

  backup_window_start {
    hours = 23
    minutes = 59
  }

  host {
    zone      = var.default_zone
    subnet_id = yandex_vpc_subnet.private.id
  }

  host {
    zone      = var.private_subnet_2.subnet_zone
    subnet_id = yandex_vpc_subnet.private_2.id
  }
}

//
// Create a new MDB MySQL Database.
//
resource "yandex_mdb_mysql_database" "mysql_db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = "netology_db"
}

//
// Create a new MDB MySQL Database User.
//
resource "yandex_mdb_mysql_user" "mysql_user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = "user"
  password   = "password"

  permission {
    database_name = yandex_mdb_mysql_database.mysql_db.name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}