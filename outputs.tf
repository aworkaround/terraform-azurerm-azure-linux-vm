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
  value       = azurerm_public_ip.pip[0].fqdn
  description = "VM DNS name, can be used to SSH or access the HTTP/HTTPS service if you're running that."
}

output "username" {
  value       = azurerm_linux_virtual_machine.vm.admin_username
  description = "VM Username [Default: azureuser]"
}

output "ssh_command" {
  value       = join("", ["ssh ", azurerm_linux_virtual_machine.vm.admin_username, "@", azurerm_public_ip.pip[0].fqdn])
  description = "This will give you a command that you can use and SSH to your VM."
}

output "ssh_hostname" {
  value       = join("", [azurerm_linux_virtual_machine.vm.admin_username, "@", azurerm_public_ip.pip[0].fqdn])
  description = "This will give you a user@hostname that you can use and SSH to your VM."
}

output "virtual_network_name" {
  value       = var.create_vnet_and_subnet == true ? azurerm_virtual_network.vnet[0].name : null
  description = "Virtual network name if created within module, else null"
}

output "virtual_network_id" {
  value = var.create_vnet_and_subnet == true ? azurerm_virtual_network.vnet[0].id : null
  description = "Virtual network ID if created within module, else null"
}

output "subnet_id" {
  value       = var.create_vnet_and_subnet == true ? azurerm_subnet.snet[0].id : local.subnet_id
  description = "Subnet ID of Virtual Machine"
}

output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "Virtual machine ID"
}

output "resource_group_name" {
  value       = var.create_resource_group == true ? azurerm_resource_group.rg[0].name : local.resource_group_name
  description = "Resource group name"
}

output "location" {
  value       = local.location
  description = "Location"
}

output "label" {
  value = var.label
  description = "Project label"
}
