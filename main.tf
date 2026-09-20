# resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
#   vm_id     = 100         # Sztywne ID maszyny (musi być wolne w Proxmoxie)
#   node_name = "pve"       # Nazwa Twojego węzła Proxmox
#   name      = "ubuntu-vm" # Nazwa hosta nowej maszyny

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048 # 2 GB RAM
  }

  disk {
    datastore_id = "local-lvm" # Nazwa Twojego storage w Proxmoxie
    file_id      = ""         # Tutaj możesz wskazać obraz ISO lub zostawić puste
    size         = 20         # 20 GB dysku
  }

  network_device {
    bridge = "vmbr0" # Twoja sieć / bridge w Proxmoxie
  }
}
