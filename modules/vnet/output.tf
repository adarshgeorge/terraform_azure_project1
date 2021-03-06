output "id_resource_group" {
  value = azurerm_resource_group.resource_group.id
}

output "name_resource_group" {
  value = azurerm_resource_group.resource_group.name
}

output "location_resource_group" {
  value = azurerm_resource_group.resource_group.location
}

output "id_vnet" {
  value = azurerm_virtual_network.vnet.id
}

output "name_vnet" {
  value = azurerm_virtual_network.vnet.name
}

output "address_space_vnet" {
  value = azurerm_virtual_network.vnet.address_space
} 

output "id_nsg" {
  value = azurerm_network_security_group.nsg.id
}

output "name_nsg" {
  value = azurerm_network_security_group.nsg.name
}

output "location_nsg" {
  value = azurerm_network_security_group.nsg.location
}



