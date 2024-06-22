resource "azurerm_virtual_network" "vnet" {
  count               = local.virtual_network_and_subnet_count
  name                = local.virtual_network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = local.address_space
}

resource "azurerm_public_ip" "pip" {
  count               = local.public_ip_count
  allocation_method   = local.public_ip_allocation_method
  resource_group_name = local.resource_group_name
  location            = local.location
  name                = local.public_ip_name
  domain_name_label   = local.domain_name_label
}

resource "azurerm_network_interface" "nic" {
  name                = local.network_interface_name
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = local.private_ip_allocation_method
    public_ip_address_id          = try(azurerm_public_ip.pip[0].id, null)
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = local.vm_name
  location            = local.location
  resource_group_name = local.resource_group_name
  size                = local.vm_size
  admin_username      = local.vm_username
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = local.vm_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = local.os_disk_storage_account_type
    name                 = local.os_disk_name
  }

  source_image_reference {
    publisher = local.vm_image_publisher
    offer     = local.vm_image_offer
    version   = local.vm_image_version
    sku       = local.vm_image_sku
  }
}
