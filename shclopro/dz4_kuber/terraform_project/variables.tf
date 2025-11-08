
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
  default = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "netology-v"
  description = "VPC network&subnet name"
}

variable "public_subnet" {
  type = object({
      subnet_name=string,
      cidr=list(string)
  })
  default = {
      subnet_name="public",
      cidr=["192.168.10.0/24"]  
  }
}

variable "public_subnet_2" {
  type = object({
      subnet_name=string,
      subnet_zone=string,
      cidr=list(string)
  })
  default = {
      subnet_name="public_2",
      subnet_zone="ru-central1-b",
      cidr=["192.168.11.0/24"]  
  }
}

variable "public_subnet_3" {
  type = object({
      subnet_name=string,
      subnet_zone=string,
      cidr=list(string)
  })
  default = {
      subnet_name="public_3",
      subnet_zone="ru-central1-d",
      cidr=["192.168.12.0/24"]  
  }
}

variable "private_subnet" {
  type = object({
      subnet_name=string,
      cidr=list(string)
  })
  default = {
      subnet_name="private",
      cidr=["192.168.20.0/24"] 
  }
}

variable "private_subnet_2" {
  type = object({
      subnet_name=string,
      subnet_zone=string,
      cidr=list(string)
  })
  default = {
      subnet_name="private_2",
      subnet_zone="ru-central1-b",
      cidr=["192.168.21.0/24"] 
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts-oslogin"
}



variable "vm_nat" {
  type = object({
     name = string,
     platform_id=string,
     preemptible=bool,  
     cpu=number,
     ram=number,
     core_fraction=number,      
     image_id=string,
     disk_volume=number,
     ip_address=string,
     nat=bool,
     })

     default = {
     name = "vm-nat",
     platform_id="standard-v3",
     preemptible=true,  
     cpu=2,
     ram=1,
     core_fraction=20, 
     image_id="fd80mrhj8fl2oe87o4e1"
     disk_volume=20,
     ip_address="192.168.10.254",
     nat=true,
     }
}

variable "vm_public" {
  type = object({
     name = string,
     platform_id=string,
     preemptible=bool,  
     cpu=number,
     ram=number,
     core_fraction=number, 
     disk_volume=number,
     nat=bool,
     })

     default = {
     name = "vm-public",
     platform_id="standard-v3",
     preemptible=true,  
     cpu=2,
     ram=1,
     core_fraction=20,
     disk_volume=20,
     nat=true,
     }
}

variable "vm_private" {
  type = object({
     name = string,
     platform_id=string,
     preemptible=bool,  
     cpu=number,
     ram=number,
     core_fraction=number, 
     disk_volume=number,
     nat=bool,
     })

     default = {
     name = "vm-private",
     platform_id="standard-v3",
     preemptible=true,  
     cpu=2,
     ram=1,
     core_fraction=20,
     disk_volume=20,
     nat=true,
     }
}

variable "storage_bucket" {
  type = object({
     name = string,
     iam_name = string,
     force_destroy=string,
     object_acl=string,
     object_key=string,
     object_source=string,
     
     })

     default = {
     name = "netology-vakhtanov-bucket",
     iam_name = "backet-cr-decr",
     force_destroy="true",
     object_acl="public-read",
     object_key="curves.jpg",
     object_source="./curves.jpg",
     }
}

variable "instance_group" {
  type = object({
     user_name = string,
     name = string,
     deletion_protection = bool
     instance_platform_id = string
     instance_memory = number
     instance_cores = number
     instance_image_id = string
     
     })

     default = {
     user_name = "ig-user",
     name = "autoscaled-ig",
     deletion_protection = false
     instance_platform_id = "standard-v3"
     instance_memory = 4
     instance_cores = 2
     instance_image_id = "fd827b91d99psvq5fjit"

     }
}
variable "instance_group_policy" {
  type = object({
      initial_size           = number
      measurement_duration   = number
      cpu_utilization_target = number
      min_zone_size          = number
      max_size               = number
      warmup_duration        = number
      stabilization_duration = number
     })

     default = {
      initial_size           = 3
      measurement_duration   = 60
      cpu_utilization_target = 75
      min_zone_size          = 3
      max_size               = 15
      warmup_duration        = 60
      stabilization_duration = 120

     }
}

variable "kuber_iam2" {
  type = object({
     name = string,
     description = string,
     role=string,
     })

     default = {
     name = "kuber-user",
     description = "аcc kubernetes",
     role="editor",
     #role="k8s.editor",
     #role="k8s.clusters.agent",
     }
}

variable "kuber_cluster" {
  type = object({
     name = string,
     description = string,
     version=string,
     name_group = string,
     description_group = string,
     description_platform_id = string,
     scale_policy_initial = number,
     scale_policy_max = number,
     scale_policy_min = number,
     })

     default = {
     name = "kuber-cluster-netologu",
     description = "кластер кубера",
     version="1.30",
     name_group = "netology-nodekuber",
     description_group = "dz4",
     description_platform_id = "standard-v2",
     scale_policy_initial = 3,
     scale_policy_max = 6,
     scale_policy_min = 3,
     }
}