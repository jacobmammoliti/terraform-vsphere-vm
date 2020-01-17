provider "vsphere" {
 allow_unverified_ssl = true
}

module "vault" {
  source  = "tfe.cdcug.local/arctiq/vm/vsphere"
  version = "0.0.2"

  datastore         = "CDCUG_VMware_general"
  cluster           = "cluster01"
  network           = "VM Network"
  datacenter        = "cdcug"
  template          = "centos-7.7-template2"
  domain            = "cdcug.local"
  vmname            = "vault"
  instances         = 2
  folder            = "jacob"
}

output "vault_ips" {
  value = module.vault.instance_ip_addr
}
