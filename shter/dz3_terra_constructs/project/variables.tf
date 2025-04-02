###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

# variable "metadata" {
#   type = object({
#     serial-port-enable = number
#     ssh-keys = string
#   })
#   default = {
#     serial-port-enable = 1
#     ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTRHAYxyx+c6YhJTk/gDE166Xa0R+EIZNa9lwnF+R3k netology-terraform"
#   }
# }

variable "each_vm" {
  type = list(object({ 
     vm_name=string,
     platform_id=string,
     preemptible=bool,  
     cpu=number,
     core_fraction=number, 
     ram=number, 
     image_id=string,
     disk_volume=number,
     }))

     default = [ {
     vm_name="main",
     platform_id="standard-v3",
     preemptible=true,  
     cpu=4,
     core_fraction=20, 
     ram=4, 
     image_id="fd8r7e7939o13595bpef" ,
     disk_volume=30,
     },
     {
     vm_name="replica",
     platform_id="standard-v3",
     preemptible=true,  
     cpu=2,
     core_fraction=20, 
     ram=2, 
     image_id="fd8r7e7939o13595bpef" ,
     disk_volume=20,

     }
     
      ]
}