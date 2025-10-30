
resource "yandex_storage_bucket" "netology_vakhtanov_bucket" {
  bucket = var.storage_bucket.name
  force_destroy = var.storage_bucket.force_destroy
#  acl    = var.storage_bucket.object_acl

}

//
// Create a new Storage Object in Bucket.
//
resource "yandex_storage_object" "sample-picture" {
  acl    = var.storage_bucket.object_acl
  bucket = var.storage_bucket.name
  key    = var.storage_bucket.object_key
  source = var.storage_bucket.object_source
  depends_on = [
    yandex_storage_bucket.netology_vakhtanov_bucket,
  ]
}