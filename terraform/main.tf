locals {
  active_vms = { for name, vm in var.vms : name => vm if vm.enabled }
  ssh_keys   = concat([trimspace(file(pathexpand(var.ssh_public_key_path)))], var.extra_ssh_keys)
}

# Dotychczasowa VM (rk-core -> lnx-core) trafia do mapy bez niszczenia.
moved {
  from = proxmox_virtual_environment_vm.rocky
  to   = proxmox_virtual_environment_vm.rocky["lnx-core"]
}

resource "proxmox_virtual_environment_vm" "rocky" {
  for_each = local.active_vms

  name      = each.key
  node_name = var.pve_node
  vm_id     = each.value.vmid
  tags      = sort(["terraform", "rocky", each.value.role])
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
    sockets = each.value.sockets
    cores   = each.value.cores
    type    = "host"
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = each.value.disk
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
        address = "${each.value.ip}/${var.prefix_length}"
        gateway = var.gateway
      }
    }

    user_account {
      username = var.admin_user
      keys     = local.ssh_keys
    }
  }

  lifecycle {
    ignore_changes = [initialization[0].user_account]
  }
}