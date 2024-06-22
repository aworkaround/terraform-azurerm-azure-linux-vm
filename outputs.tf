output "public_ip_address" {
  value       = azurerm_public_ip.pip[0].ip_address
  description = "VM Public IP address"
  depends_on  = [azurerm_public_ip.pip]
}

output "private_ip_address" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "VM Private IP address"
}

output "vm_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "VM DNS name, can be used to SSH or access the HTTP/HTTPS service if you're running that."
}

output "username" {
  value       = azurerm_linux_virtual_machine.vm.admin_username
  description = "VM Username [Default: azureuser]"
}

output "ssh_command" {
  value       = join("", ["ssh ", azurerm_linux_virtual_machine.vm.admin_username, "@", azurerm_public_ip.pip.fqdn])
  description = "This will give you a command that you can use and SSH to your VM."
}
