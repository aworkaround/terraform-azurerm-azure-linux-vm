# Example Usage


```terraform

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "CentralIndia"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet" {
  name                 = "subnet-one"
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 0)]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

module "linux_virtual_machine" {
  source              = "aworkaround/azure-linux-vm/azurerm"
  version             = "0.0.1"
  resource_group_name = "my-resource-group"
  location            = "CentralIndia"
  subnet_id           = azurerm_subnet.snet.id
  vm_name             = "my-virtual-machine"
  create_public_ip    = true
  vm_size             = "Standard_B1s"
}

```