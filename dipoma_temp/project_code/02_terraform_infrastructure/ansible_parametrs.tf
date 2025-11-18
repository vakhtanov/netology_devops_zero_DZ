resource "local_file" "parameters_templatefile" {
  content = templatefile("${path.module}/parameters.json.tftpl", {})
  filename = "${abspath(path.module)}/../03_ansible_kubernetes/parameters.json"
}
