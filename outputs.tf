output "ip_address" {
  value = azurerm_public_ip.pip[0].ip_address
}

output "username" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}
