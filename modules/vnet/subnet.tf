resource "azurerm_subnet" "public" {
  name                 = var.pub_subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.pub_subnet_ip_range
}

resource "azurerm_subnet" "private" {
  name                 = var.priv_subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.priv_subnet_ip_range
}


resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg1_subnet_association" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

