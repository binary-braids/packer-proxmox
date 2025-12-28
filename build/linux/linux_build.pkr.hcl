source "proxmox-iso" "linux" {
    proxmox_url = "${var.proxmox_url}"
    username = "${var.proxmox_username}"
    token = "${var.proxmox_token}"
    
    # VM General Settings
    node = var.proxmox_node
    vm_name = var.vm_name
    vm_bios = var.vm_bios
    template_description = var.template_description

    efi_config {
      efi_storage_pool = var.efi_storage_pool
      efi_format = var.efi_format
      efi_type = var.efi_type
    }

    # VM OS Settings
    iso_file = var.iso_file
    iso_storage_pool = var.iso_storage_pool
    unmount_iso = true
    os = var.os

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = var.scsi_controller

    disks {
      disk_size = var.disk_size
      format = var.disk_format
      storage_pool = var.storage_pool
      type = var.disk_type
    }

    # VM CPU Settings
    cores = var.cpu_cores
    
    # VM Memory Settings
    memory = var.vm_memory

    # VM Network Settings
    network_adapters {
      model = var.nic_model
      bridge = var.nic_bridge
      firewall = var.nic_firewall
    } 

    # VM Cloud-Init Settings
    cloud_init = true
    cloud_init_storage_pool = var.cloud_init_storage_pool

    # PACKER Boot Commands
    boot_command = var.boot_command 
    boot_wait = "10s"

    # PACKER Autoinstall Settings
    http_directory = "http"
    http_port_min = 8800
    http_port_max = 8810

    ssh_username = "packer"
    ssh_timeout = "20m"
}

build {
  sources = ["source.proxmox-iso.linux"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"
    ]
  }

  provisioner "file" {
    source      = "../files/linux/regenerate_ssh_host_keys.service"
    destination = "/tmp/regenerate_ssh_host_keys.service"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/regenerate_ssh_host_keys.service /etc/systemd/system/regenerate_ssh_host_keys.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable regenerate_ssh_host_keys.service"
    ]
  }

  provisioner "file" {
    source      = "../scripts/linux/setup.sh"
    destination = "/tmp/setup.sh"
  }

  provisioner "shell" {
    inline = ["sudo bash /tmp/setup.sh"]
  }

  provisioner "shell" {
    inline = [
      "echo '> Resetting cloud-init config ...'",
      "sudo rm -f /etc/cloud/cloud.cfg.d/99-installer.cfg",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo sed -i 's|nocloud-net;s=http://.*/|proxmox|' /etc/default/grub",
      "sudo update-grub",
      "sudo cloud-init clean"
    ]
  }
}