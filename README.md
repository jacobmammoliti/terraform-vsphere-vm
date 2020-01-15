# Terraform vSphere Virtual Machine Module
This module handles vSphere Linux Virtual Machine creation and customization. This module is able to:

* Provision single/multiple Linux virtual machines from a template
* Customize CPU and memory
* Add additional data disks
* Customize virtual machine with hostname and domain

## Compatibility
This module is meant for use with Terraform 0.12. If you haven't upgraded, upgrade steps can be found [here](https://www.terraform.io/upgrade-guides/0-12.html).

## Setup
This module is designed to use environment variables to target and log into a vSphere environment. The following environment variables must be set before using this module.

* `VSPHERE_USER` - username for vSphere API operations
* `VSPHERE_PASSWORD` - password for vSphere API operations
* `VSPHERE_SERVER` - address of vCenter/ESXi host for vSphere API operations

## Usage
The following is a simple example where we are deploying two VMs based off a Centos 7 template, increase RAM from default to 8GB, and deploy into a specific folder:

```hcl
# Use the terraform-vsphere-vm module to deploy two Kubernetes servers
module "kubernetes" {
  source  = "../."

  datastore         = "CDCUG_VMware_general"
  cluster           = "cluster01"
  network           = "VM Network"
  datacenter        = "cdcug"
  template          = "centos-7.7-template"
  domain            = "cdcug.local"
  vmname            = "kubernetes"
  memory_count      = 8192
  instances         = 2
  folder            = "jacob"
}
```

## Inputs
### Required Inputs
The following varaibels must be set in the `module` block when using this module.

| Name | Description | Type |
|------|-------------|------|
| cluster | cluster to deploy VM into | string |
| datacenter | datacenter to deploy VM into | string |
| datastore | datastore to deploy VM disk on | string|
| domain | domain for VM | string |
| folder | folder to deploy VMs into | string |
| instances | number of VMs to provision | string |
| network | network to attach VM NIC to | string |
| template | name of template to use for VM | string |
| vmname | prefix to give VM name and hostname | string |

### Optional Inputs
These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

| Name | Description | Type | Default |
|------|-------------|------|---------|
| cpu_count | CPU count for VM | string | 2 |
| data_disk_size_gb | storage data disk size in gb | list | [] |
| memory_count | memory count for VM | string| 4096 |