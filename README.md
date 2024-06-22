# Example Usage

```terraform

provider "azurerm" {
  features {}
}

module "example_vm" {
  source             = "aworkaround/azure-linux-vm/azurerm"
  version            = "1.0.0"
  vnet_address_space = ["10.0.0.0/16"]
  location           = "centralindia"
  label              = "EXAMPLE"
}

```