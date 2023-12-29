######################################
## Azure Resource Group
######################################

resource "azurerm_resource_group" "myrg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

######################################
## Azure Virtual Network
######################################

resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = var.address_space
}

######################################
## Azure Subnet
######################################

resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "web_subnet" {
  name                 = var.web_subnet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = var.db_subnet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.4.0/24"]
}


#######################################
## Azure Network Security Group
#######################################

resource "azurerm_network_security_group" "mynsg" {
  name                = "nsg_group"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}


#######################################
## Associate NSG - Subnet
#######################################

resource "azurerm_subnet_network_security_group_association" "bastion_subnet_association" {
  network_security_group_id = azurerm_network_security_group.mynsg.id
  subnet_id                 = azurerm_subnet.bastion_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_association" {
  network_security_group_id = azurerm_network_security_group.mynsg.id
  subnet_id                 = azurerm_subnet.web_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_association" {
  network_security_group_id = azurerm_network_security_group.mynsg.id
  subnet_id                 = azurerm_subnet.app_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_association" {
  network_security_group_id = azurerm_network_security_group.mynsg.id
  subnet_id                 = azurerm_subnet.db_subnet.id
}

########################################
## NSG Rules
########################################

locals {
  web_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  }
}
resource "azurerm_network_security_rule" "nsg-rule" {
  for_each                    = local.web_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.mynsg.name
}