data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

locals {
  template_disk_count = length(var.data_disk_size_gb)
}

resource "vsphere_virtual_machine" "vm" {
  count            = var.instances
  name             = var.instances != 1 ? "${var.vmname}-${count.index}" : var.vmname
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpu_count
  memory    = var.memory_count
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  folder = var.folder

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  # defined disks from template
  dynamic "disk" {
    for_each = data.vsphere_virtual_machine.template.disks

    content {
      label            = "disk${disk.key}"
      unit_number      = disk.key
      size             = data.vsphere_virtual_machine.template.disks[disk.key].size
      eagerly_scrub    = data.vsphere_virtual_machine.template.disks[disk.key].eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.template.disks[disk.key].thin_provisioned
    }
  }

  # defined additional disks by users
  dynamic "disk" {
    for_each = var.data_disk_size_gb

    content {
      label            = "disk${disk.key + local.template_disk_count}"
      size             = var.data_disk_size_gb[disk.key]
      unit_number      = disk.key + local.template_disk_count
    }
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.instances != 1 ? "${var.vmname}-${count.index}" : var.vmname
        domain    = var.domain
      }
      
      network_interface {}
    }
  }
}