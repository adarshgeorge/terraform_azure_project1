resource azurerm_network_security_group "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_network_security_rule" "allow_myip" {
  name                        = "allow_myip"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.my_ip
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource azurerm_network_security_group "nsg1" {
  name                = var.nsg1_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}
resource "azurerm_network_security_rule" "allow_web_ip" {
  name                        = "allow_web_ip"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "3306"
  destination_port_range      = "*"
  source_address_prefix       = var.private_vm1_ip
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
