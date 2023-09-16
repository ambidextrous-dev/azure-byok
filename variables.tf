variable "resource_group_name" {
  type        = string
  description = "Name of resource group for this project"
  nullable    = false
}

variable "location" {
  type        = string
  description = "Resource location in Azure"
  nullable    = false
}
