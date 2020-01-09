variable "vm_count" {
  type        = string
  description = "number of VMs to provision"
}

variable "cpu_count" {
  type        = string
  description = "CPU count for VM"
  default     = 2
}

variable "memory_count" {
  type        = string
  description = "memory count for VM"
  default     = 8192
}

variable "folder" {
  type        = string
  description = "folder to deploy VMs into"
}