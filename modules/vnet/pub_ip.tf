resource "azurerm_public_ip" "vm_pub_ip" {
  name                    = "pubip1"
  location                = azurerm_resource_group.resource_group.location
  resource_group_name     = azurerm_resource_group.resource_group.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}
