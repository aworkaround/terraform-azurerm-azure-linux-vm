data "azurerm_resource_group" "rg" {
  count = local.resource_group_data_count
  name  = local.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = local.resource_group_count
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  count               = local.vnet_and_subnet_count
  name                = local.vnet_name
  location            = local.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name
  address_space       = local.vnet_address_space
}

resource "azurerm_subnet" "snet" {
  count                = local.vnet_and_subnet_count
  address_prefixes     = local.subnet_address_prefixes
  name                 = local.subnet_name
  resource_group_name  = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
}

resource "azurerm_public_ip" "pip" {
  count               = local.public_ip_count
  allocation_method   = local.public_ip_allocation_method
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name
  location            = local.location
  name                = local.public_ip_name
  domain_name_label   = local.domain_name_label
}

resource "azurerm_network_interface" "nic" {
  name                = local.network_interface_name
  location            = local.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.create_public_ip ? azurerm_subnet.snet[0].id : local.subnet_id
    private_ip_address_allocation = local.private_ip_allocation_method
    public_ip_address_id          = try(azurerm_public_ip.pip[0].id, null)
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = local.vm_name
  location            = local.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name
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
