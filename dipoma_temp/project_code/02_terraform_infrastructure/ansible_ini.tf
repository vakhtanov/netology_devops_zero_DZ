resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
      control_node = yandex_compute_instance.control_node
      worker_node  = yandex_compute_instance.worker_node
      #storage = [yandex_compute_instance.storage]
    }
  )
  filename = "${abspath(path.module)}/../03_ansible_kubernetes/inventory.ini"
}

#resource "local_file" "ansible_cfg" {
#  content = "[defaults]\ninventory = inventory.ini\nhost_key_checking = False\nremote_user = wahha\nprivate_key_file = #~/.ssh/wahha_rsa"
#  filename = "${abspath(path.module)}/../03_ansible_kubernetes/ansible.cfg"
#}