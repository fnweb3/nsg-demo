#Variables tenant and subscription
variable "subscription_id" {
    description = "Azure Subscription ID"
    default     = ""
    type = string
}
variable "tenant_id" {
    description = "Azure Tenant ID"
    default     = ""
    type = string
}
variable "rg_nsg" {
    description = "name resource group aadds"
    type = string
}
variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}
variable "vnet" {
  type        = string
  description = "Address range for deployment VNet"
}
variable "name_vnet" {
  type        = string
  description = "name vnet"
}
variable "subnet" {
  type        = string
  description = "Address range for session host subnet"
}
variable "name_subnet" {
  type        = string
  description = "name subnet"
}
variable "name_nsg" {
  type        = string
  description = "name network security group"
}