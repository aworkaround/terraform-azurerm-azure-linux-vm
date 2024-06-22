variable "vm_name" {
  type        = string
  description = "Please provide a Virtual Machine Name [Default: <location>-<label>-VM]"
  default     = null
  nullable    = true
}

variable "label" {
  description = "Project Label can be used in RG name if RG name is not provided [Default: VM]"
  default     = "VM"
  type        = string
}

variable "location" {
  type        = string
  description = "Resources Location [Required]"
}

variable "create_public_ip" {
  type        = bool
  description = "Weather you want to create and attach a new Public IP to the VM? [Default: true]"
  default     = true
}

variable "vm_size" {
  type        = string
  description = "VM SKU [Default: Standard_b1s]"
  default     = "Standard_b1s"
}

variable "public_ip_allocation_method" {
  default     = "Dynamic"
  description = "Dynamic or Static [Default: Dynamic]"
  type        = string
}

variable "domain_name_label" {
  description = "DNS name label for Public IP [Default: <vm-name>-<random-hex>]"
  default     = null
  nullable    = true
  type        = string
}

variable "private_ip_allocation_method" {
  description = "Private IP allocation method for the VM [Default: Dynamic]"
  default     = "Dynamic"
  type        = string
}

variable "vm_username" {
  description = "VM username [Default: azureuser]"
  default     = "azureuser"
  type        = string
}

variable "vm_image_publisher" {
  description = "VM Publisher [Default: Canonical]"
  default     = "Canonical"
  type        = string
}

variable "vm_image_offer" {
  description = "VM Offer [Default: 0001-com-ubuntu-server-focal]"
  default     = "0001-com-ubuntu-server-focal"
  type        = string
}

variable "vm_image_sku" {
  description = "VM SKU [Default: 20_04-lts]"
  default     = "20_04-lts"
  type        = string
}

variable "vm_image_version" {
  description = "VM Image Version [Default: latest]"
  default     = "latest"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type of the OS disk [Default: Standard_LRS]"
  default     = "Standard_LRS"
  type        = string
}

variable "create_resource_group" {
  type        = bool
  description = "Do you want to create a Resource Group? [Default: true]"
  default     = true
}

variable "resource_group_name" {
  type        = string
  description = "Name of Existing Resource Group [Required if create_resource_group is set to false]"
  default     = null
  nullable    = true
}

variable "create_vnet_and_subnet" {
  type        = bool
  description = "Do you want to create a Virtual Network and Subnet? [Default: true]"
  default     = true
}

variable "subnet_id" {
  type        = string
  description = "Please provide existing Subnet ID only if you set create_virtual_network_and_subnet to false [Default: null]"
  default     = null
  nullable    = true
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Please provide list of VNET address spaces [Default: [10.0.0.0/16]]"
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Please provide list of Subnet address prefixes. [Default: vnet_address_space will be divided and used]"
  default     = null
  nullable    = true
}
