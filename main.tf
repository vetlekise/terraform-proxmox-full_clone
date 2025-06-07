resource "proxmox_vm_qemu" "vm" {
  lifecycle {
    ignore_changes = [vm_state]
  }
  # Basic VM config
  name        = var.vm_name
  target_node = var.proxmox_target_node
  tags        = var.tags
  vmid        = var.vmid

  # OS / Agent / Display
  qemu_os = var.qemu_os
  agent   = var.agent_enabled ? 1 : 0
  bios    = "seabios"

  vga {
    type = var.vga_type
  }

  # Cloning
  clone      = var.clone
  full_clone = var.full_clone

  # State and protection
  vm_state   = var.vm_state
  protection = var.protection

  # Hardware
  cores   = var.vm_cores
  sockets = var.vm_sockets
  memory  = var.vm_memory
  scsihw  = var.scsihw

  # Boot order
  # order=ide2;scsi0;net0;ide0 (using variables for managed slots)
  boot = "order=ide2;${var.disk_slot};net0;${var.cloudinit_disk_slot}"

  # Network configuration
  network {
    id       = 0 # Required ID for the network interface (net0)
    model    = var.network_model
    bridge   = var.network_bridge
    firewall = var.network_firewall
  }

  # Disk configuration
  disks {
    scsi {
      scsi0 {
        disk {
          storage    = var.disk_storage
          size       = var.disk_size
          discard    = var.os_disk_discard
          iothread   = var.os_disk_iothread
          emulatessd = var.os_disk_ssd
          # replicate = false # Default
          # backup = true # Default
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = var.cloudinit_disk_storage
        }
      }
      ide2 {
        cdrom {}
      }
    }
  }

  # Cloud-Init configuration
  ipconfig0    = var.ipconfig0
  ciuser       = var.ciuser
  cipassword   = var.cipassword
  sshkeys      = local.ssh_keys_content
  nameserver   = var.nameserver != null ? var.nameserver : null
  searchdomain = var.searchdomain != null ? var.searchdomain : null
}
