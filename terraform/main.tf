terraform {
  required_version = ">= 1.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.0"
    }
  }
}

variable "ansible_user" {
  default = "ansible"
}

variable "ansible_ssh_private_key" {
  default = "/root/.ssh/id_rsa"
}

variable "nodes" {
  default = {
    ubuntu = { ip = "172.20.0.21" }
    fedora = { ip = "172.20.0.22" }
    redhat = { ip = "172.20.0.23" }
  }
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tpl")
  vars = {
    ansible_user            = var.ansible_user
    ansible_ssh_private_key = var.ansible_ssh_private_key
    ubuntu_ip               = var.nodes["ubuntu"].ip
    fedora_ip               = var.nodes["fedora"].ip
    redhat_ip               = var.nodes["redhat"].ip
  }
}

resource "local_file" "inventory_output" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.module}/../inventory/hosts.ini"
}

output "inventory_path" {
  value = resource.local_file.inventory_output.filename
}
