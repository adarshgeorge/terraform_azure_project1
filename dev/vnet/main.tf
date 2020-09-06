terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  version         = "2.24.0"
  features {
    
  }
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

module "vnet" {
  source                      = "../../modules/vnet/"
  resource_group_location     = var.resource_group_location
  vnet_name                   = var.vnet_name
  resource_group_name         = var.resource_group_name
  vnet_ip_range               = var.vnet_ip_range
  nsg_name                    = var.nsg_name
  my_ip                       = var.my_ip
  pub_subnet_name             = var.pub_subnet_name
  pub_subnet_ip_range         = var.pub_subnet_ip_range
  priv_subnet_name            = var.priv_subnet_name
  priv_subnet_ip_range        = var.priv_subnet_ip_range
  private_vm1_ip              = var.private_vm1_ip
  private_vm2_ip              = var.private_vm2_ip
  image_reference             = var.image_reference
  vm_size                     = var.vm_size
  vm_1_user                   = var.vm_1_user
  vm_1_password               = var.vm_1_password
  vm_2_user                   = var.vm_2_user
  vm_2_password               = var.vm_2_password


}
