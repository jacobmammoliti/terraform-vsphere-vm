variable "instances" {
  description = "number of VMs to provision"
}

variable "cpu_count" {
  description = "CPU count for VM"
  default     = 2
}

variable "memory_count" {
  description = "memory count for VM"
  default     = 4096
}

variable "folder" {
  type        = string
  description = "folder to deploy VMs into"
}

variable "datastore" {
  type        = string
  description = "datastore to deploy VM disk on"
}

variable "cluster" {
  type        = string
  description = "cluster to deploy VM into"
}

variable "network" {
  type        = string
  description = "network to attach VM NIC to"
}

variable "datacenter" {
  type        = string
  description = "datacenter to deploy VM into"
}

variable "template" {
  type        = string
  description = "name of template to use for VM"
}

variable "domain" {
  type        = string
  description = "domain for VM"
}

variable "vmname" {
  type        = string
  description = "prefix to give VM name and hostname"
}

variable "data_disk_size_gb" {
  type         = list
  description  = "storage data disk size in gb"
  default      = []
}