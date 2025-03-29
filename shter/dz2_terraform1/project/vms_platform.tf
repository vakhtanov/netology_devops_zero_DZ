
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = ""  
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v2"
  description = ""  
}

# variable "vm_db_cores" {
#   type        = number
#   default     = 2
#   description = ""  
# }

# variable "vm_db_memory" {
#   type        = number
#   default     = 2
#   description = ""  
# }

# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 20
#   description = ""  
# }

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = ""  
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = ""  
}

variable "vm_db_serial-port-enable" {
  type        = number
  default     = 1
  description = ""  
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "vm_db_develop"
  description = "VPC network & subnet name"
}


