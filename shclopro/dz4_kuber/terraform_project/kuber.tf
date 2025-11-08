resource "yandex_iam_service_account" "kuber-account" {
  name        = var.kuber_iam2.name
  description = var.kuber_iam2.description
}

resource "yandex_resourcemanager_folder_iam_member" "kuber-editor" {
  #cluster_id = yandex_kubernetes_cluster.netology_regional_cluster.id
  folder_id = var.folder_id
  role      = var.kuber_iam2.role
  member    = "serviceAccount:${yandex_iam_service_account.kuber-account.id}"
}


resource "yandex_kms_symmetric_key" "kuber_key" {
  name        = "kuber-key-symmetric_key"
  description = "symmetric_key"
  default_algorithm = "AES_256"
  rotation_period = "2592000s" # 30 дней
}

//
// Create a new Managed Kubernetes regional Cluster.
//
resource "yandex_kubernetes_cluster" "netology_regional_cluster" {
  name        = var.kuber_cluster.name
  description = var.kuber_cluster.description
  network_id = yandex_vpc_network.develop.id
  service_account_id      = yandex_iam_service_account.kuber-account.id
  node_service_account_id = yandex_iam_service_account.kuber-account.id
  release_channel = "STABLE"  
  
  kms_provider {
    key_id = yandex_kms_symmetric_key.kuber_key.id
  }

  master {
    version   = var.kuber_cluster.version
    public_ip = true

    regional {
      region = "ru-central1"

      location {
        zone      = var.default_zone
        subnet_id = yandex_vpc_subnet.public.id
      }

      location {
        zone      = var.public_subnet_2.subnet_zone
        subnet_id = yandex_vpc_subnet.public_2.id
      }

      location {
        zone      = var.public_subnet_3.subnet_zone
        subnet_id = yandex_vpc_subnet.public_3.id
      }
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "monday"
        start_time = "15:00"
        duration   = "3h"
      }      
    }

    master_logging {
      enabled                    = true
      folder_id                  = var.folder_id
      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }
  }

  depends_on = [
  yandex_resourcemanager_folder_iam_member.kuber-editor
  ] 
}


//
// Create a new Managed Kubernetes Node Group.
//
resource "yandex_kubernetes_node_group" "netology_cluster_group" {
  cluster_id  = yandex_kubernetes_cluster.netology_regional_cluster.id
  name        = var.kuber_cluster.name_group
  description = var.kuber_cluster.description_group
  version     = var.kuber_cluster.version

  instance_template {
    platform_id = var.kuber_cluster.description_platform_id

    network_interface {
      nat        = true
      subnet_ids = [
        yandex_vpc_subnet.public.id,
          ]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale  {
      initial  = var.kuber_cluster.scale_policy_initial
      max  = var.kuber_cluster.scale_policy_max
      min = var.kuber_cluster.scale_policy_min
    }
  }

   allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  } 

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }
  }
}
