terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.50.0"
    }
  }

  # Ścieżkę do stanu podajemy przy init (-backend-config), bo checkout
  # czyści katalog roboczy i skasowałby plik stanu.
  backend "local" {}
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure
}