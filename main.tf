resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  node_name = "pve" # Nazwa Twojego noda w Proxmoxie
  name      = "terraform-test-vm"
  cpu {
    cores = 2
  }
  memory {
    dedicated = 2048
  }
  # Przykładowa konfiguracja dysku, sieci itp.
}
