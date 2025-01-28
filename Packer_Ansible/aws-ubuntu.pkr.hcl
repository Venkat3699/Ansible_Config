packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">=1.2.9"
    }
  }
}


source "amazon-ebs" "ubuntu" {
  ami_name      = "Ansible-Packer"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-04b4f1a9cf54c11d0"
  ssh_username  = "ubuntu"
  tags = {
    Name = "Ansible-Packer-{{isotime | clean_resource_name}}"
  }
}

build {
  name   = "Ansible-Build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo apt update",
      "sudo apt install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y"
    ]
  }
}