provider "vsphere" {
 allow_unverified_ssl = true
}

module "vault-servers" {
  source  = "tfe.cdcug.local/arctiq/demo/vmware"
  version = "0.0.1"

  datastore         = "CDCUG_VMware_general"
  cluster           = "cluster01"
  network           = "VM Network"
  datacenter        = "cdcug"
  template          = "centos-7.7-template"
  domain            = "cdcug.local"
  vmname            = "vault"
  instances         = 1
  folder            = "jacob"
  data_disk_size_gb = [25]
}

#output "gitlab_ips" {
#  value = module.vault-servers.vm_ips
#}

module "kubernetes-servers" {
  source  = "tfe.cdcug.local/arctiq/demo/vmware"
  version = "0.0.1"

  datastore         = "CDCUG_VMware_general"
  cluster           = "cluster01"
  network           = "VM Network"
  datacenter        = "cdcug"
  template          = "centos-7.7-template"
  domain            = "cdcug.local"
  vmname            = "kubernetes"
  instances         = 2
  folder            = "jacob"
}

#output "kubernetes_ips" {
#  value = module.kubernetes-servers.vm_ips
#}
