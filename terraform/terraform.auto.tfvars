extra_ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Rhv1mZ3UWwhD9BxtQrlRMiHS1I1+McDWXn06c+8xw michal@Mac",
]

vms = {
  lnx-core = {
    vmid = 201, 
    role = "core", 
    ip = "192.168.8.211"

    cores = 2,
    memory = 2048, 
    disk = 20
  }

  lnx-mon = {
    vmid = 202, 
    role = "monitoring", 
    ip = "192.168.8.212"
    cores = 8, 
    memory = 2048, 
    disk = 30
  }
}