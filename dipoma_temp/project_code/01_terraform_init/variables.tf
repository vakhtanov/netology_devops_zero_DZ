variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "netology-vah_dipl"
  description = "VPC for diploma"
}

variable "terraform-account" {
  type        = string
  default     = "terraform-account"
}

variable "storage_bucket" {
  type = object({
     name = string,
     iam_name = string,
     force_destroy=string,
     
     })

     default = {
     name = "netology-vakhtanov-diploma-state-bucket",
     iam_name = "terraform-diploma-key",
     force_destroy="true",
     }
}

