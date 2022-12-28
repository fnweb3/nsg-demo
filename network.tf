terraform {
  required_version = ">= 1.1.6"

  required_providers {
    azurerm = {
      source  = "azurerm"
      version = ">= 2.97.0"
    }
  }
}

provider "azurerm" {
   features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
 }

resource "azurerm_resource_group" "armvnet" {
  name     = var.rg_nsg 
  location = var.location
}

resource "azurerm_virtual_network" "avn" {
  name                = var.name_vnet 
  address_space       = [var.vnet]
  location            = azurerm_resource_group.armvnet.location
  resource_group_name = azurerm_resource_group.armvnet.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.name_subnet
  resource_group_name  = azurerm_resource_group.armvnet.name
  virtual_network_name = azurerm_virtual_network.avn.name
  address_prefixes     = [var.subnet]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.name_nsg
  location            = azurerm_resource_group.armvnet.location
  resource_group_name = azurerm_resource_group.armvnet.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}