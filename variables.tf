variable "resource_group_name" {
  type        = string
  description = "Name of Existing Resource Group [Required]"
}

variable "location" {
  type        = string
  description = "Resources Location [Required]"
}

variable "subnet_id" {
  type        = string
  description = "Please provide existing subnet ID [Required]"
}

variable "vm_name" {
  type        = string
  description = "Please provide a Virtual Machine Name [Default: test-vm-one]"
  default     = "test-vm-one"
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
