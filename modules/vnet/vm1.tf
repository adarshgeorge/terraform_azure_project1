
resource "azurerm_network_interface" "public" {
  name                = "nic1"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_vm1_ip
    public_ip_address_id          = azurerm_public_ip.vm_pub_ip.id
  }
}

resource "azurerm_virtual_machine" "public" {
  name                  = "vm1"
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.public.id]
  vm_size               = var.vm_size

    # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = lookup(var.image_reference, "publisher")
    offer     = lookup(var.image_reference, "offer")
    sku       = lookup(var.image_reference, "sku")
    version   = lookup(var.image_reference, "version")
  }
  storage_os_disk {
    name              = "OsDisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm1"
    admin_username = var.vm_1_user
    admin_password = var.vm_1_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}