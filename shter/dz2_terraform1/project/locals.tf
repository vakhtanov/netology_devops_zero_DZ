locals {
base-name = "netology-develop-platform"
sub_name_web = "web"
sub_name_db = "db"
web-name = "${local.base-name}-${local.sub_name_web}"
db-name = "${local.base-name}-${local.sub_name_db}"
}