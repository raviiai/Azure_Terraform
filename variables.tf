##################################
## Resource Group Variable
##################################

variable "resource_group_name" {
  description = "Azure resource Group Name"
}

variable "resource_group_location" {
  description = "Resource Group Location"
  default     = "West Europe"
}

###################################
## Virtual Network Variable
###################################

variable "vnet_name" {
  description = "Virtual Network Name"
}

variable "address_space" {
  description = "Vnet Address Space"
  default     = ["10.0.0.0/16"]
  type        = list(string)
}

variable "vnet_location" {
  description = "VNet Location Name"
  default     = "West Europe"
}

########################################
## SubNet Variable
########################################

variable "bastion_subnet_name" {
  description = "Bastion Subnet Name"
}

variable "web_subnet_name" {
  description = "Web Subnet Name"
}

variable "app_subnet_name" {
  description = "App Subnet Name"
}

variable "db_subnet_name" {
  description = "DB Subnet Name"
}