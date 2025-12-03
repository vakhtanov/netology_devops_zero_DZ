#ключи для дальнейшей авторизации terraform
output "terraform-account-key" {
  value = {
    id                 = yandex_iam_service_account_key.terraform-account-key.id
    service_account_id = yandex_iam_service_account_key.terraform-account-key.service_account_id
    created_at         = yandex_iam_service_account_key.terraform-account-key.created_at
    key_algorithm      = yandex_iam_service_account_key.terraform-account-key.key_algorithm
    public_key         = yandex_iam_service_account_key.terraform-account-key.public_key
    private_key        = yandex_iam_service_account_key.terraform-account-key.private_key
  }
  sensitive = true
}
### terraform output -json terraform-account-key > ~/.terraform-account-key.json

output "terraform-backend-key" {
  value = "terraform init -backend-config=\"access_key=${yandex_iam_service_account_static_access_key.terraform-account-key.access_key}\" -backend-config=\"secret_key=${yandex_iam_service_account_static_access_key.terraform-account-key.secret_key}\"" 
  sensitive = true
}

output "docker_build_command" {
  value = "docker build . -t cr.yandex/${yandex_container_registry.default.id}/nginx-app:v0.0.0" 
  #sensitive = true
}

output "docker_pull_command" {
  value = "docker pull cr.yandex/${yandex_container_registry.default.id}/nginx-app:v0.0.0" 
  #sensitive = true

}