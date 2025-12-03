//
// Create a new Container Registry.
//
resource "yandex_container_registry" "default" {
  name      = "netology-diplom-registry"
  folder_id = var.folder_id

  labels = {
    my-label = "netology-diplom-registry"
  }
}

//
// Create a new IAM Binding for it.
//

resource "yandex_container_registry_iam_binding" "puller" {
  registry_id = yandex_container_registry.default.id
  role        = "container-registry.images.puller"
// все пользователи, даже не авторизованные
  members = [
    "system:allUsers",
  ]
}