resource "yandex_iam_service_account" "terraform-account" {
  name        = var.terraform-account
  description = "аккаунт для инфраструктуры"
}

resource "yandex_resourcemanager_folder_iam_member" "terraform-account-role" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform-account.id}"
}

#resource "yandex_resourcemanager_folder_iam_member" "storage-admin" {
#  folder_id = var.folder_id
#  role      = "storage.admin"
#  member    = "serviceAccount:${yandex_iam_service_account.terraform-account.id}"
#}

resource "yandex_iam_service_account_key" "terraform-account-key" {
  service_account_id = "${yandex_iam_service_account.terraform-account.id}"
  description        = "Доступ к ресурсам "
}

resource "yandex_iam_service_account_static_access_key" "terraform-account-key" {
  service_account_id = "${yandex_iam_service_account.terraform-account.id}"
  description        = "Доступ к  бакету"
}

resource "yandex_storage_bucket" "netology_vakhtanov_bucket" {
  bucket = var.storage_bucket.name
  force_destroy = var.storage_bucket.force_destroy

  access_key = "${yandex_iam_service_account_static_access_key.terraform-account-key.access_key}"
  secret_key = "${yandex_iam_service_account_static_access_key.terraform-account-key.secret_key}"


  depends_on = [ yandex_iam_service_account.terraform-account]
}
