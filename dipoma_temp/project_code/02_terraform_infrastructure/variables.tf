variable "access_key" {
  type        = string
  default     = ""
}

variable "secret_key" {
  type        = string
  default     = ""
}

variable "cloud_id" {
  type        = string
  default     = "b1gbnkafeirsgsvi0dtd"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1g0jl4hsmsh89fu01vr"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "netology-vah-diploma"
  description = "VPC for diploma"
}

variable "public_subnet" {
  type = object({
    name = string,
    zone = string,
    cidr = list(string)
  })
  default = {
    name = "public-subnet-a",
    zone = "ru-central1-a",
    cidr = ["192.168.100.0/24"]
  }
}

variable "nodes_subnets" {
  type = list(object({
    name = string,
    zone = string,
    cidr = list(string)
  }))
  default = [{
    name = "subnet-a",
    zone = "ru-central1-a",
    cidr = ["192.168.10.0/24"]
    },
    {
      name = "subnet-b",
      zone = "ru-central1-b",
      cidr = ["192.168.20.0/24"]
    },
    {
      name = "subnet-d",
      zone = "ru-central1-d",
      cidr = ["192.168.30.0/24"]
  }]
}


data "yandex_compute_image" "ubuntu-2204" {
  family = "ubuntu-2204-lts-oslogin"
}

data "yandex_compute_image" "rocky" {
  family = "rocky-9-oslogin"
}


#control_node_params
#IPv4 forwarding
variable "control_node" {
  type = object({
    platform_id   = string,
    allow_stopping_for_update = bool,
    preemptible   = bool,
    cpu           = number,
    core_fraction = number,
    ram           = number,
    disk_volume   = number,
    nat           = bool,
  })

  default = {
    platform_id   = "standard-v3",
    allow_stopping_for_update = true,
    preemptible   = true,
    cpu           = 2,
    core_fraction = 20,
    ram           = 4,
    disk_volume   = 40,
    nat           = true,
  }
}

#worker_node_params
#IPv4 forwarding
variable "worker_node" {
  type = object({
    vm_num        = number,
    platform_id   = string,
    allow_stopping_for_update = bool,
    preemptible   = bool,
    cpu           = number,
    core_fraction = number,
    ram           = number,
    disk_volume   = number,
    nat           = bool,
  })

  default = {
    vm_num = 2
    platform_id   = "standard-v3",
    allow_stopping_for_update = true,
    preemptible   = true,
    cpu           = 2,
    core_fraction = 50,
    ram           = 6,
    disk_volume   = 40,
    nat           = true,
  }
}


# public manage vm
variable "manage_vm" {
  type = object({
    create_vm = bool,
    platform_id   = string,
    preemptible   = bool,
    cpu           = number,
    core_fraction = number,
    ram           = number,
    disk_volume   = number,
    nat           = bool,
  })

  default = {
    create_vm = false
    platform_id   = "standard-v3",
    preemptible   = true,
    cpu           = 2,
    core_fraction = 20,
    ram           = 2,
    disk_volume   = 30,
    nat           = true,
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts-oslogin"
}


variable "vm_nat" {
  type = object({
    name          = string,
    platform_id   = string,
    preemptible   = bool,
    cpu           = number,
    ram           = number,
    core_fraction = number,
    image_id      = string,
    disk_volume   = number,
    ip_address    = string,
    nat           = bool,
  })

  default = {
    name          = "vm-nat",
    platform_id   = "standard-v3",
    preemptible   = true,
    cpu           = 2,
    ram           = 1,
    core_fraction = 20,
    image_id      = "fd80mrhj8fl2oe87o4e1"
    disk_volume   = 20,
    ip_address    = "192.168.10.254",
    nat           = true,
  }
}

variable "vm_public" {
  type = object({
    name          = string,
    platform_id   = string,
    preemptible   = bool,
    cpu           = number,
    ram           = number,
    core_fraction = number,
    disk_volume   = number,
    nat           = bool,
  })

  default = {
    name          = "vm-public",
    platform_id   = "standard-v3",
    preemptible   = true,
    cpu           = 2,
    ram           = 1,
    core_fraction = 20,
    disk_volume   = 20,
    nat           = true,
  }
}

variable "vm_private" {
  type = object({
    name          = string,
    platform_id   = string,
    preemptible   = bool,
    cpu           = number,
    ram           = number,
    core_fraction = number,
    disk_volume   = number,
    nat           = bool,
  })

  default = {
    name          = "vm-private",
    platform_id   = "standard-v3",
    preemptible   = true,
    cpu           = 2,
    ram           = 1,
    core_fraction = 20,
    disk_volume   = 20,
    nat           = true,
  }
}

### NLB

variable "worker_node_tg_name" {
  type        = string
  default     = "worker-node-tg"
}

variable "worker_node_nlb" {
  type = object({
    name          = string,
    healt_name   = string,
    healt_port    = number,
    healt_path    = string,
    listener_name   = string,
    listener_port    = number,
    listener_protocol = string,
    listener_target_port = number,
    listener_address    = string,
  })

  default = {
    name          = "worker-node-nlb",
    healt_name   = "http",
    healt_port   = 80,
    healt_path   = "/",
    listener_name   = "worker-node-istener",
    listener_port   = 80,
    listener_protocol = "TCP",
    listener_target_port = 80,
    listener_address   = "51.250.77.76",
  }
}