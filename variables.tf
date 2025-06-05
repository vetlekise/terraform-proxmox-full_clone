variable "vm_name" {
  description = "Name for the virtual machine."
  type        = string
}

variable "vmid" {
  description = "The unique VMID for the VM. If set to 0 (default), Proxmox will assign the next available ID."
  type        = number
  default     = 0
}

variable "clone" {
  description = "The name of the EXISTING Proxmox template to clone from."
  type        = string
}

# --- Proxmox Target ---
variable "proxmox_target_node" {
  description = "Proxmox node where the VM will be created."
  type        = string
}

variable "pool_name" {
  description = "Optional: Name of a Proxmox resource pool to create and assign the VM to. If null or empty, no pool is created/used."
  type        = string
  default     = null
}

variable "tags" {
  description = "A list of tags to apply to the virtual machine."
  type        = list(string)
}

variable "vm_state" {
  description = "Desired state for the VM after creation - 'running' or 'stopped'."
  type        = string
  default     = "stopped"
  validation {
    condition     = contains(["running", "stopped"], var.vm_state)
    error_message = "Allowed values for vm_state are 'running' or 'stopped'."
  }
}

variable "protection" {
  description = "If true, enable the protection flag on the VM in Proxmox."
  type        = bool
  default     = false
}

variable "vm_memory" {
  description = "Memory (in MiB) for the VM."
  type        = number
  default     = 2048
}

variable "vm_cores" {
  description = "Number of CPU cores per socket for the VM."
  type        = number
  default     = 2
}

variable "vm_sockets" {
  description = "Number of CPU sockets for the VM."
  type        = number
  default     = 1
}

variable "scsihw" {
  description = "SCSI hardware controller type (e.g., 'virtio-scsi-pci', 'lsi'). Should match template."
  type        = string
  default     = "virtio-scsi-single"
}

variable "qemu_os" {
  description = "Guest OS type for Proxmox optimizations (e.g., 'l26' for Linux)."
  type        = string
  default     = "l26"
}

variable "agent_enabled" {
  description = "Enable the QEMU Guest Agent (requires agent installed in the source template)."
  type        = bool
  default     = true
}

variable "full_clone" {
  description = "Set to true for a full clone, false for a linked clone."
  type        = bool
  default     = true
}

variable "vga_type" {
  description = "Display type (e.g., 'serial0', 'std')."
  type        = string
  default     = "std"
}

# --- Disk Configuration ---
variable "disk_storage" {
  description = "Storage pool for the VM's primary OS disk (e.g., 'local-lvm')."
  type        = string
}

variable "disk_slot" {
  description = "The slot for the primary OS disk (e.g., 'scsi0', 'virtio0')."
  type        = string
  default     = "scsi0"
}

variable "disk_size" {
  description = "Required: Target size of the primary OS disk (e.g., '32G'). Must be provided even when cloning."
  type        = string
}

variable "os_disk_discard" {
  description = "Enable/disable discard (TRIM) for the OS disk."
  type        = bool
  default     = true
}

variable "os_disk_iothread" {
  description = "Enable/disable iothread for the OS disk (requires scsihw='virtio-scsi-single')."
  type        = bool
  default     = true
}

variable "os_disk_ssd" {
  description = "Emulate SSD for the OS disk (ssd=1)."
  type        = bool
  default     = true
}


variable "cloudinit_disk_storage" {
  description = "Required: Storage pool for the Cloud-Init drive (must support snippets/ISO images, e.g., 'local', 'local-lvm')."
  type        = string
}

variable "cloudinit_disk_slot" {
  description = "Disk slot for the Cloud-Init drive (e.g., 'ide0', 'ide2', 'sata1')."
  type        = string
  default     = "ide0"
}

variable "ciuser" {
  description = "Cloud-Init username to configure."
  type        = string
  default     = "adminuser"
}

variable "cipassword" {
  description = "Cloud-Init user password. **Warning: Sensitive**. Consider using SSH keys exclusively."
  type        = string
  default     = null
  sensitive   = true
}

variable "ssh_public_keys" {
  description = "String containing newline-separated public SSH keys. Use 'ssh_public_keys_file' instead."
  type        = string
  default     = null
  sensitive   = true
}

variable "ssh_public_keys_file" {
  type        = string
  default     = null
  description = "Path to a file containing SSH public keys. This is mutually exclusive with 'ssh_public_keys'."

  validation {
    condition     = var.ssh_public_keys_file == null || fileexists(var.ssh_public_keys_file)
    error_message = "If 'ssh_public_keys_file' is specified, the file must exist and be readable."
  }
}

variable "ipconfig0" {
  description = "IP configuration for the VM's first network interface (net0) (e.g., 'ip=dhcp' or 'ip=10.0.0.5/24,gw=10.0.0.1')."
  type        = string
  default     = "ip=dhcp"
}

variable "nameserver" {
  description = "DNS server for the VM (applied via Cloud-Init during clone)."
  type        = string
  default     = null
}

variable "searchdomain" {
  description = "DNS search domain for the VM (applied via Cloud-Init during clone)."
  type        = string
  default     = null
}

variable "network_bridge" {
  description = "Network bridge for the VM's network interface (e.g., 'vmbr0')."
  type        = string
}

variable "network_model" {
  description = "Network card model (e.g., 'virtio', 'e1000')."
  type        = string
  default     = "virtio"
}

variable "network_firewall" {
  description = "Enable/disable Proxmox firewall on the network interface."
  type        = bool
  default     = true
}
