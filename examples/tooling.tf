provider "vsphere" {
 allow_unverified_ssl = true
}

# use the terraform-vsphere-vm module to deploy a GitLab server
module "gitlab" {
	source  = "../."

  datastore         = "CDCUG_VMware_general"
  cluster           = "cluster01"
  network           = "VM Network"
  datacenter        = "cdcug"
  template          = "centos-7.7-template"
  domain            = "cdcug.local"
  vmname            = "gitlab"
  instances         = 1
  folder            = "jacob"
  data_disk_size_gb = [50]
}

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