##################################
## Resource Group Output
##################################
output "Resource_Group_Name" {
  value = azurerm_resource_group.myrg.name
}

##################################
## Virtual Network Output
##################################

output "Virtual_Network_Name" {
  value = azurerm_virtual_network.myvnet.name
}
output "Virtual_Network_ID" {
  value = azurerm_virtual_network.myvnet.id
}

##################################
## Subnet Output
##################################

output "Subnet_Name_Web" {
  value = azurerm_subnet.web_subnet.name
}

output "Subnet_ID_Web" {
  value = azurerm_subnet.web_subnet.id
}
output "Subnet_Name_App" {
  value = azurerm_subnet.app_subnet.name
}
output "Subnet_ID_app" {
  value = azurerm_subnet.app_subnet.id
}
output "Subnet_Name_bastion" {
  value = azurerm_subnet.bastion_subnet.name
}
output "nameSubnet_ID_bastion" {
  value = azurerm_subnet.bastion_subnet.id
}
output "Subnet_Name_db" {
  value = azurerm_subnet.db_subnet.name
}
output "Subnet_ID_db" {
  value = azurerm_subnet.db_subnet.id
}



##################################
## Network Security Output
##################################

