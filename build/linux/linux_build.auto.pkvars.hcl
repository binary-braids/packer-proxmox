proxmox_url = "#{PROXMOX_API_URL}#"
proxmox_username = "#{PROXMOX_USERNAME}"
proxmox_token = "#{PROXMOX_TOKEN}"

proxmox_node = "#{PROXMOX_NODE}"
vm_name = "pkr-ubuntu-2404"
vm_bios = "ovmf"
template_description = "Ubuntu 24.04 template built by Hashicorp Packer"
efi_storage_pool = "VM-240GB-SSD2"
efi_format = "raw"
efi_type = "4m"
iso_file = "local:iso/ubuntu-24.04.3-live-server-amd64.iso"
iso_storage_pool = "local"
os = "l26"
scsi_controller = "virtio-scsi-pci"
disk_size = "20G"
disk_format = "raw"
storage_pool = "VM-240GB-SSD2"
disk_type = "scsi"
cores = 2
vm_memory = "2048"
nic_model = "virtio"
nic_bridge = "vmbr0"
nic_firewall = true
cloud_init_storage_pool = "VM-240GB-SSD2"

boot_command = [
  "<wait3s>c<wait3s>",
  "linux /casper/vmlinuz --- autoinstall ds=nocloud-net;s={{ .HTTPIP }}:{{ .HTTPPort }}/",
  "initrd /casper/initrd",
  "<enter><wait>",
  "boot",
  "<enter>"
]

