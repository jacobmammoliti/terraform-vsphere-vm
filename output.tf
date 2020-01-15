output "instance_ip_addr" {
  value = vsphere_virtual_machine.vm.*.default_ip_address
}
