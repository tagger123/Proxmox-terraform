variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "pve_node" {
  type    = string
  default = "pve-01"
}

variable "template_vm_id" {
  type    = number
  default = 9000
}

variable "datastore" {
  type    = string
  default = "local-lvm"
}

variable "lab_bridge" {
  type    = string
  default = "vmbr0"
}

variable "gateway" {
  type    = string
  default = "192.168.8.1"
}

variable "dns_servers" {
  type    = list(string)
  default = ["192.168.8.1"]
}

variable "domain" {
  type    = string
  default = "homelab.lan"
}

variable "prefix_length" {
  type    = number
  default = 24
}

variable "admin_user" {
  type    = string
  default = "admin"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "extra_ssh_keys" {
  description = "Dodatkowe klucze publiczne SSH (np. z laptopa)"
  type        = list(string)
  default     = []
}

variable "vms" {
  description = "Mapa maszyn. Klucz = nazwa VM, role = grupa w Ansible."
  type = map(object({
    vmid    = number
    role    = string
    ip      = string
    sockets = number
    cores   = number
    memory  = number
    disk    = number
    enabled = optional(bool, true)
  }))
}