
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


variable "test" {
  type        = map(list(string))
  default     = {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ] 
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
    }
}