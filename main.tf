resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  node_name = "pve-01" # Nazwa Twojego noda w Proxmoxie
  name      = "terraform-test-vm"
  cpu {
    cores = 2
    cores = 4
  }
  memory {
    dedicated = 2048
  }
  # Przykładowa konfiguracja dysku, sieci itp.
}
