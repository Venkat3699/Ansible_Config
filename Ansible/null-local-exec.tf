resource "null_resource" "webservers" {
  provisioner "local-exec" {
    command = <<EOH
      sleep 30
      timeout 300 ansible -i invfile pub -m ping
    EOH
  }
  depends_on = [local_file.ansible_inventory_file]
}
