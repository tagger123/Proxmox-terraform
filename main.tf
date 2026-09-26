resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  node_name = "pve-01" # Nazwa Twojego noda w Proxmoxie
  name      = "Rocky-test-vm-01"

  clone {
    vm_id = 9000
    full  = true
  }

  cpu {
    cores   = 2
    sockets = 4
    type    = "host"
  }

  memory {
    dedicated = 8192
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 40
  }

  network_device {
    bridge = "vmbr1"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.10.50.220/24"
        gateway = "10.10.50.1"
      }
    }

    user_account {
        username = "admin"
        keys     = [file(pathexpand("~/.ssh/id_ed25519.pub"))]
    }
  }

  agent {
    enabled = true
  }
}
