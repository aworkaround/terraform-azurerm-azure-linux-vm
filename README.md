# Example Usage


```terraform

resource "azurerm_resource_group" "rg" {
  name = "my-resource-group"
  location = "CentralIndia"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name = "subnet-one"
    address_prefix = "10.0.0.0/24"
  }
}

module "linux_virtual_machine" {
  source              = ""
  resource_group_name = "my-resource-group" # Existing Resource Group.
  location            = "CentralIndia"
  subnet_id           = azurerm_subnet.snet.id
  vm_name             = "my-virtual-machine"
  create_public_ip    = true
  vm_size             = "Standard_b1s"
}

```