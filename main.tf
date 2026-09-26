resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  node_name = "pve-01" # Nazwa Twojego noda w Proxmoxie
  name      = "Rocky-test-vm-01"

  clone {
    vm_id = 9000
    full  = true
  }

  cpu {
    cores = 4
    type = "host"
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
  }

  network_device {
    bridge = "vmbr1"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.50/24"
        gateway = "192.168.1.1"
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
