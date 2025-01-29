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
    Name = "Ansible-Packer"
  }
}

build {
  name   = "Ansible-Build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo apt install -y software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible",
      "sudo apt install -y unzip",  
      "curl -o awscliv2.zip 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
      "aws --version",
      "wget https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip",
      "unzip terraform_1.10.5_linux_amd64.zip",
      "sudo mv terraform /usr/local/bin/",
      "terraform --version",
      "sudo rm -rf awscliv2.zip terraform_1.10.5_linux_amd64.zip"  
    ]
  }
}