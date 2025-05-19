locals {
  # Read SSH key content from file if specified, otherwise use direct string (or null)
  ssh_keys_content = var.ssh_public_keys_file != null ? file(var.ssh_public_keys_file) : var.ssh_public_keys
}
