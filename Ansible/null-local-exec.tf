resource "null_resource" "wait_for_ssh" {
  provisioner "local-exec" {
    command = <<EOT
      # Fetch instance IPs dynamically from Terraform
      INSTANCES="${join(" ", aws_instance.example[*].public_ip)}"

      # Check SSH connectivity for each instance
      for i in $(seq 1 30); do
        ALL_READY=true
        for IP in $INSTANCES; do
          if ! nc -zv $IP 22; then
            echo "Waiting for SSH on $IP..."
            ALL_READY=false
          fi
        done

        if [ "$ALL_READY" = true ]; then
          echo "All instances are accessible via SSH!"
          break
        fi

        sleep 10
      done

      # Check if all instances are ready
      if [ "$ALL_READY" = false ]; then
        echo "Timeout waiting for SSH access. Exiting."
        exit 1
      fi

      # Run Ansible only after SSH is available
      timeout 120 ansible -i invfile pub -m ping -vvv
    EOT
  }
  depends_on = [local_file.ansible_inventory_file]
}