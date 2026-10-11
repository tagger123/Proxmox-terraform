output "vms" {
  description = "Aktywne maszyny: nazwa => IP"
  value       = { for name, vm in local.active_vms : name => vm.ip }
}