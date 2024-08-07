resource "random_string" "dns_label" {
  count     = var.domain_name_label == null ? 1 : 0
  min_lower = 4
  length    = 4
}

locals {
  vm_name                      = var.vm_name != null ? upper(var.vm_name) : join("-", [upper(var.location), upper(var.label), "VM"])
  vm_size                      = var.vm_size
  vm_username                  = var.vm_username
  vm_image_publisher           = var.vm_image_publisher
  vm_image_offer               = var.vm_image_offer
  vm_image_sku                 = var.vm_image_sku
  vm_image_version             = var.vm_image_version
  os_disk_name                 = join("-", [local.vm_name, "DISK"])
  os_disk_storage_account_type = var.os_disk_storage_account_type
  location                     = var.location
  resource_group_name          = var.resource_group_name != null ? var.resource_group_name : join("-", [upper(local.location), upper(var.label), "RG"])
  resource_group_count         = var.create_resource_group == true ? 1 : 0
  resource_group_data_count    = var.create_resource_group == true ? 0 : 1
  public_ip_name               = join("-", [upper(local.vm_name), "PIP"])
  public_ip_count              = var.create_public_ip == true ? 1 : 0
  public_ip_allocation_method  = var.public_ip_allocation_method
  private_ip_allocation_method = var.private_ip_allocation_method
  vnet_and_subnet_count        = var.create_vnet_and_subnet == true ? 1 : 0
  vnet_name                    = join("-", [upper(local.location), upper(var.label), "VNET"])
  subnet_name                  = join("-", [upper(local.location), upper(var.label), "SNET"])
  subnet_id                    = var.subnet_id
  vnet_address_space           = var.vnet_address_space != null ? var.vnet_address_space : ["10.0.0.0/16"]
  subnet_address_prefixes      = var.subnet_address_prefixes != null ? var.subnet_address_prefixes : [cidrsubnet(local.vnet_address_space[0], 8, 0)]
  domain_name_label            = var.domain_name_label != null ? var.domain_name_label : join("-", [lower(local.vm_name), random_string.dns_label[0].result])
  network_interface_name       = join("-", [upper(local.vm_name), "NIC"])
}
