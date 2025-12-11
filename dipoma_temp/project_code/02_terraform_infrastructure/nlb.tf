// Create a new NLB Target Group.
//

locals {
  worker_targets = [
    for vm in yandex_compute_instance.worker_node :
    {
      subnet_id = vm.network_interface[0].subnet_id
      address   = vm.network_interface[0].ip_address
    }
  ]
}


resource "yandex_lb_target_group" "worker_node_tg" {
  name      = var.worker_node_tg_name
  region_id = "ru-central1"
  folder_id = var.folder_id

  dynamic "target" {
    for_each = local.worker_targets
    content {
      subnet_id = target.value.subnet_id
      address   = target.value.address
    }
  }
}


// Create a new Network Load Balancer (NLB).
//
resource "yandex_lb_network_load_balancer" "worker_node_nlb" {
  name      = var.worker_node_nlb.name
  region_id = "ru-central1"
  folder_id = var.folder_id

  listener {
    name        = var.worker_node_nlb.listener_name
    port        = var.worker_node_nlb.listener_port
    target_port = var.worker_node_nlb.listener_target_port
    external_address_spec {
      address    = var.worker_node_nlb.listener_address
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.worker_node_tg.id

    healthcheck {
      name = var.worker_node_nlb.healt_name
      http_options {
        port = var.worker_node_nlb.healt_port
        path = var.worker_node_nlb.healt_path
      }
    }
  }
}