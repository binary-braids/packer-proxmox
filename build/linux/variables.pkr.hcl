variable "proxmox_url" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_token" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_bios" {
  type = string
}

variable "template_description" {
  type = string
}

variable "efi_storage_pool" {
  type = string
}

variable "efi_format" {
  type = string
}

variable "efi_type" {
  type = string
}

variable "iso_file" {
  type = string
}

variable "iso_storage_pool" {
  type = string
}

variable "os" {
  type = string
}

variable "scsi_controller" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "disk_format" {
  type = string
}

variable "storage_pool" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "cores" {
  type = number
}

variable "vm_memory" {
  type = string
}

variable "nic_model" {
  type = string
}

variable "nic_bridge" {
  type = string
}

variable "nic_firewall" {
  type = bool
}

variable "cloud_init_storage_pool" {
  type = string
}

variable "boot_command" {
  type = list(string)
}