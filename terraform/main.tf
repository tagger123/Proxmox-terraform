locals {
  ssh_key = trimspace(file(pathexpand(var.ssh_public_key_path)))
}

resource "proxmox_virtual_environment_vm" "rocky" {
  name      = var.vm_name
  node_name = var.pve_node
  vm_id     = var.vm_id
  tags      = ["terraform", "rocky"]
  on_boot   = true

  clone {
    vm_id        = var.template_vm_id
    full         = true
    datastore_id = var.datastore
  }

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
    type  = "host" # Rocky 10 wymaga x86-64-v3
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = var.disk
    discard      = "on"
    ssd          = true
    iothread     = true
  }

  network_device {
    bridge = var.lab_bridge
    model  = "virtio"
  }

  operating_system {
    type = "l26"
  }

  initialization {
    datastore_id = var.datastore

    dns {
      domain  = var.domain
      servers = var.dns_servers
    }

    ip_config {
      ipv4 {
        address = "${var.vm_ip}/${var.prefix_length}"
        gateway = var.gateway
      }
    }

    user_account {
      username = var.admin_user
      keys     = [local.ssh_key]
    }
  }

  lifecycle {
    ignore_changes = [initialization[0].user_account]
  }
}