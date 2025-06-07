# Terraform Proxmox Full Clone

A Terraform module for cloning a virtual machine using full clone in Proxmox VE.

## Usage

Below is a good example of how to use this module.

```terraform
module "example" {
  source = "github.com/vetlekise/terraform-proxmox-full_clone"

  # Required
  vm_name                = "example"
  proxmox_target_node    = "proxmox-node"
  clone                  = "ubuntu-2404-noble"
  disk_storage           = "local-lvm"
  disk_size              = "32G"
  cloudinit_disk_storage = "local-lvm"
  network_bridge         = "vmbr0"

  # Cloud-Init Settings (Optional)
  ciuser               = "auto"
  ssh_public_keys_file = "keys/id_auto.pub"
  ipconfig0            = "ip=192.168.3.238/24,gw=192.168.3.1"

  # Other Optional
  vmid      = 105
  tags      = "application"
  #vm_state = "running"
  vm_memory = 4094
  vm_cores  = 2
}
```

> Beginning of generated docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.1-rc8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/telmate/proxmox/3.0.1-rc8/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_enabled"></a> [agent\_enabled](#input\_agent\_enabled) | Enable the QEMU Guest Agent (requires agent installed in the source template). | `bool` | `true` | no |
| <a name="input_cipassword"></a> [cipassword](#input\_cipassword) | Cloud-Init user password. **Warning: Sensitive**. Consider using SSH keys exclusively. | `string` | `null` | no |
| <a name="input_ciuser"></a> [ciuser](#input\_ciuser) | Cloud-Init username to configure. | `string` | `"adminuser"` | no |
| <a name="input_clone"></a> [clone](#input\_clone) | The name of the EXISTING Proxmox template to clone from. | `string` | n/a | yes |
| <a name="input_cloudinit_disk_slot"></a> [cloudinit\_disk\_slot](#input\_cloudinit\_disk\_slot) | Disk slot for the Cloud-Init drive (e.g., 'ide0', 'ide2', 'sata1'). | `string` | `"ide0"` | no |
| <a name="input_cloudinit_disk_storage"></a> [cloudinit\_disk\_storage](#input\_cloudinit\_disk\_storage) | Required: Storage pool for the Cloud-Init drive (must support snippets/ISO images, e.g., 'local', 'local-lvm'). | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Required: Target size of the primary OS disk (e.g., '32G'). Must be provided even when cloning. | `string` | n/a | yes |
| <a name="input_disk_slot"></a> [disk\_slot](#input\_disk\_slot) | The slot for the primary OS disk (e.g., 'scsi0', 'virtio0'). | `string` | `"scsi0"` | no |
| <a name="input_disk_storage"></a> [disk\_storage](#input\_disk\_storage) | Storage pool for the VM's primary OS disk (e.g., 'local-lvm'). | `string` | n/a | yes |
| <a name="input_full_clone"></a> [full\_clone](#input\_full\_clone) | Set to true for a full clone, false for a linked clone. | `bool` | `true` | no |
| <a name="input_ipconfig0"></a> [ipconfig0](#input\_ipconfig0) | IP configuration for the VM's first network interface (net0) (e.g., 'ip=dhcp' or 'ip=10.0.0.5/24,gw=10.0.0.1'). | `string` | `"ip=dhcp"` | no |
| <a name="input_nameserver"></a> [nameserver](#input\_nameserver) | DNS server for the VM (applied via Cloud-Init during clone). | `string` | `null` | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Network bridge for the VM's network interface (e.g., 'vmbr0'). | `string` | n/a | yes |
| <a name="input_network_firewall"></a> [network\_firewall](#input\_network\_firewall) | Enable/disable Proxmox firewall on the network interface. | `bool` | `true` | no |
| <a name="input_network_model"></a> [network\_model](#input\_network\_model) | Network card model (e.g., 'virtio', 'e1000'). | `string` | `"virtio"` | no |
| <a name="input_os_disk_discard"></a> [os\_disk\_discard](#input\_os\_disk\_discard) | Enable/disable discard (TRIM) for the OS disk. | `bool` | `true` | no |
| <a name="input_os_disk_iothread"></a> [os\_disk\_iothread](#input\_os\_disk\_iothread) | Enable/disable iothread for the OS disk (requires scsihw='virtio-scsi-single'). | `bool` | `true` | no |
| <a name="input_os_disk_ssd"></a> [os\_disk\_ssd](#input\_os\_disk\_ssd) | Emulate SSD for the OS disk (ssd=1). | `bool` | `true` | no |
| <a name="input_protection"></a> [protection](#input\_protection) | If true, enable the protection flag on the VM in Proxmox. | `bool` | `false` | no |
| <a name="input_proxmox_target_node"></a> [proxmox\_target\_node](#input\_proxmox\_target\_node) | Proxmox node where the VM will be created. | `string` | n/a | yes |
| <a name="input_qemu_os"></a> [qemu\_os](#input\_qemu\_os) | Guest OS type for Proxmox optimizations (e.g., 'l26' for Linux). | `string` | `"l26"` | no |
| <a name="input_scsihw"></a> [scsihw](#input\_scsihw) | SCSI hardware controller type (e.g., 'virtio-scsi-pci', 'lsi'). Should match template. | `string` | `"virtio-scsi-single"` | no |
| <a name="input_searchdomain"></a> [searchdomain](#input\_searchdomain) | DNS search domain for the VM (applied via Cloud-Init during clone). | `string` | `null` | no |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | String containing newline-separated public SSH keys. Use 'ssh\_public\_keys\_file' instead. | `string` | `null` | no |
| <a name="input_ssh_public_keys_file"></a> [ssh\_public\_keys\_file](#input\_ssh\_public\_keys\_file) | Path to a file containing SSH public keys. This is mutually exclusive with 'ssh\_public\_keys'. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to apply to the virtual machine. | `list(string)` | `[]` | no |
| <a name="input_vga_type"></a> [vga\_type](#input\_vga\_type) | Display type (e.g., 'serial0', 'std'). | `string` | `"std"` | no |
| <a name="input_vm_cores"></a> [vm\_cores](#input\_vm\_cores) | Number of CPU cores per socket for the VM. | `number` | `2` | no |
| <a name="input_vm_memory"></a> [vm\_memory](#input\_vm\_memory) | Memory (in MiB) for the VM. | `number` | `2048` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name for the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_sockets"></a> [vm\_sockets](#input\_vm\_sockets) | Number of CPU sockets for the VM. | `number` | `1` | no |
| <a name="input_vm_state"></a> [vm\_state](#input\_vm\_state) | Desired state for the VM after creation - 'running' or 'stopped'. | `string` | `"stopped"` | no |
| <a name="input_vmid"></a> [vmid](#input\_vmid) | The unique VMID for the VM. If set to 0 (default), Proxmox will assign the next available ID. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_default_ipv4_address"></a> [vm\_default\_ipv4\_address](#output\_vm\_default\_ipv4\_address) | The default IPv4 address reported by the guest agent. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | The Proxmox VMID of the created VM. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the created VM. |
| <a name="output_vm_node"></a> [vm\_node](#output\_vm\_node) | The Proxmox node the VM was created on. |
| <a name="output_vm_ssh_user"></a> [vm\_ssh\_user](#output\_vm\_ssh\_user) | The Cloud-Init user configured for the VM. |
<!-- END_TF_DOCS -->

> End of generated docs

## Contributing
Start by reviewing [CONTRIBUTING.md](./docs/CONTRIBUTING.md) for guidelines on how to contribute to this project.
