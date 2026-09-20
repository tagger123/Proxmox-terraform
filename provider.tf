terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.68.0" # Dostosuj do aktualnej wersji
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_api_url
  api_token = var.proxmox_api_token
  # Jeśli używasz self-signed certyfikatu w homelabie:
  insecure = true
}
