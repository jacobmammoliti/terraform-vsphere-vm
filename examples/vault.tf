provider "vsphere" {
 allow_unverified_ssl = true
}

module "vault-servers" {
	source  = "../."

  datastore         = "CDCUG_VMware_general"
  cluster           = "cluster01"
  network           = "VM Network"
  datacenter        = "cdcug"
  template          = "centos-7.7-template"
  domain            = "cdcug.local"
  vmname            = "vault"
  instances         = 1
  folder            = "jacob"
  data_disk_size_gb = [50]
}