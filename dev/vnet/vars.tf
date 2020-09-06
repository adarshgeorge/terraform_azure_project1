variable subscription_id {
  description = "Subscription ID of the servcie group"
  default = "1b0a362f-2b27-4d41-a889-14b3ac922fed"
}

variable tenant_id {
  description = "Tenant ID of the service group"
  default = "3101496f-768d-4fed-acbb-0c2fb94ba50e"
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
}

variable resource_group_name {
  default = "terraform_rg"
}

variable resource_group_location {
  default = "North Europe"
}

variable vnet_name {
  default = "ter-vnet"
}

variable vnet_ip_range {
  default = "10.0.0.0/16"
}

variable pub_subnet_name {
  default = "subnet-pub"
}

variable pub_subnet_ip_range {
   default = ["10.0.2.0/24"]
   type    = list
}

variable priv_subnet_ip_range {
  default = ["10.0.3.0/24"]
   type    = list
}

variable priv_subnet_name {
  default = "subnet-priv"
}

variable private_vm1_ip {
  default = "10.0.2.5"
}

variable private_vm2_ip {
  default = "10.0.3.5"
}

variable "image_reference" {
   default = {
     "publisher" = "Canonical"
     "offer"     = "UbuntuServer"
     "sku"       = "18.04-LTS"
     "version"   = "latest"
   }
}

variable vm_size {
   default = "Standard_B2s"
}

variable vm_1_user {
   default = "azureuser"
}

variable vm_1_password {
   default = "4YDoL5O8Svw7S2D7g"
}

variable vm_2_user {
   default = "azureuser"
}

variable vm_2_password {
   default = "ZfnMqpkScChEX37Pk"
}


variable nsg_name {
  default = "ter-nsg"
}

variable my_ip {
  default = "103.148.21.226"
}
