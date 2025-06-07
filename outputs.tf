output "vm_name" {
  description = "The name of the created VM."
  value       = proxmox_vm_qemu.vm.name
}

output "vm_id" {
  description = "The Proxmox VMID of the created VM."
  value       = proxmox_vm_qemu.vm.vmid
}

output "vm_node" {
  description = "The Proxmox node the VM was created on."
  value       = proxmox_vm_qemu.vm.target_node
}

output "vm_ssh_user" {
  description = "The Cloud-Init user configured for the VM."
  value       = var.ciuser
}

output "vm_default_ipv4_address" {
  description = "The default IPv4 address reported by the guest agent."
  value       = proxmox_vm_qemu.vm.default_ipv4_address
}
