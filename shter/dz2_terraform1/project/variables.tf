###cloud vars



variable "cloud_id" {
  type        = string
  default     = "b1gbnkafeirsgsvi0dtd"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1g13qdscue4t6vtbgva"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTRHAYxyx+c6YhJTk/gDE166Xa0R+EIZNa9lwnF+R3k netology-terraform"
#   description = "ssh-keygen -t ed25519"
# }

###other varible


variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"  
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = ""  
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v2"
  description = ""  
}

# variable "vm_web_cores" {
#   type        = number
#   default     = 2
#   description = ""  
# }

# variable "vm_web_memory" {
#   type        = number
#   default     = 1
#   description = ""  
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
#   description = ""  
# }

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = ""  
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = ""  
}

variable "vm_web_serial-port-enable" {
  type        = number
  default     = 1
  description = ""  
}

variable "vms_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
  }))
  
  default = {
    "web" = {
    cores = 2
    memory = 1
    core_fraction = 5
      
    },
    "db" = {
    cores = 2
    memory = 2
    core_fraction = 20
    }
  }
}

variable "metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys = string
  })
  default = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTRHAYxyx+c6YhJTk/gDE166Xa0R+EIZNa9lwnF+R3k netology-terraform"
  }
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