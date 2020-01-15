provider "vsphere" {
 allow_unverified_ssl = true
}

module "kubernetes" {
  source  = "tfe.cdcug.local/arctiq/demo/vmware"
  version = "0.0.2"

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

output "kubernetes_ips" {
  value = module.kubernetes.instance_ip_addr
}
