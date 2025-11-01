
resource "yandex_iam_service_account" "buckets-account" {
  name        = var.storage_bucket.iam_name
  description = "аккаунт для шифрования бакета"
}

resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "buckets-encrypter-decrypter" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
}

resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
  service_account_id = "${yandex_iam_service_account.buckets-account.id}"
  description        = "Доступ к бакету"
}

resource "yandex_kms_symmetric_key" "bucket_key" {
  name        = "${var.storage_bucket.name}-symmetric_key"
  description = "symmetric_key"
  default_algorithm = "AES_256"
  rotation_period = "2592000s" # 30 дней
depends_on = [ yandex_iam_service_account.buckets-account ]
}

resource "yandex_storage_bucket" "netology_vakhtanov_bucket" {
  bucket = var.storage_bucket.name
  force_destroy = var.storage_bucket.force_destroy

  access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
  secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"

  server_side_encryption_configuration {
    rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
      sse_algorithm     = "aws:kms"
    }
  }
  }
  depends_on = [ yandex_iam_service_account.buckets-account ]
}

// Create a new Storage Object in Bucket.

resource "yandex_storage_object" "sample-picture" {
  access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
  secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"

  acl    = var.storage_bucket.object_acl
  bucket = var.storage_bucket.name
  key    = var.storage_bucket.object_key
  source = var.storage_bucket.object_source
  depends_on = [
    yandex_storage_bucket.netology_vakhtanov_bucket,
  ]
}