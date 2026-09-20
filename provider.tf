terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.50.0"
    }
  }
}

variable "proxmox_api_url" {
  type        = string
  description = "Adres URL API Proxmoxa"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "Token API Proxmoxa w formacie user@realm!token=uuid"
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true # Pomija błędy samo-podpisanych certyfikatów SSL
}
