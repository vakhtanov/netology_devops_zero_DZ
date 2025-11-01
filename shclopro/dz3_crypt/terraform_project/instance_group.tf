resource "yandex_iam_service_account" "ig-sa" {
  name        = var.instance_group.user_name
  description = "Сервисный аккаунт для управления группой ВМ."
}

resource "yandex_resourcemanager_folder_iam_member" "compute_editor" {
  folder_id = var.folder_id
  role      = "compute.editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "backet_crypt_de" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

#resource "yandex_kms_symmetric_key_iam_member" "allowiguser" {
#  symmetric_key_id = yandex_kms_symmetric_key.bucket_key.id
#  # Роль для шифрования/расшифровки 
#  role   = "kms.keys.encrypterDecrypter"
#  # member формат: serviceAccount:<id>
#  member = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
#}

resource "yandex_resourcemanager_folder_iam_member" "load-balancer-editor" {
  folder_id = var.folder_id
  role      = "load-balancer.editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

resource "yandex_compute_instance_group" "ig-1" {
  name               = var.instance_group.name 
  folder_id          = var.folder_id
  service_account_id = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = var.instance_group.deletion_protection
  instance_template {
    platform_id = var.instance_group.instance_platform_id
    resources {
      memory = var.instance_group.instance_memory
      cores  = var.instance_group.instance_cores
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.instance_group.instance_image_id
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.develop.id
      subnet_ids         = [yandex_vpc_subnet.public.id]
    }

    metadata = {
      ssh-keys = "wahha:${file("./wahha_rsa.pub")}"
      user-data = "${file("index.yaml")}"
    }
  }

  scale_policy {
    auto_scale {
      initial_size           = var.instance_group_policy.initial_size
      measurement_duration   = var.instance_group_policy.measurement_duration
      cpu_utilization_target = var.instance_group_policy.cpu_utilization_target
      min_zone_size          = var.instance_group_policy.min_zone_size
      max_size               = var.instance_group_policy.max_size
      warmup_duration        = var.instance_group_policy.warmup_duration
      stabilization_duration = var.instance_group_policy.stabilization_duration
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  health_check{
    healthy_threshold = 2
    http_options {
      path = "/"
      port = 80
    }
    interval = 2
    timeout  = 1
    unhealthy_threshold = 2
  }
  
  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.compute_editor,
    yandex_resourcemanager_folder_iam_member.load-balancer-editor,
    yandex_iam_service_account.ig-sa,
  ]

}

resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }

depends_on = [
    yandex_resourcemanager_folder_iam_member.load-balancer-editor,
    yandex_resourcemanager_folder_iam_member.compute_editor,
    yandex_iam_service_account.ig-sa,
  ]

}