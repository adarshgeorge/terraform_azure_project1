output "id_resource_group" {
  value = module.vnet.id_resource_group
}

output "name_resource_group" {
  value = module.vnet.name_resource_group
}

output "location_resource_group" {
  value = module.vnet.location_resource_group
}

output "id_vnet" {
  value = module.vnet.id_vnet
}

output "name_vnet" {
  value = module.vnet.name_vnet
}

output "address_space" {
  value = module.vnet.address_space_vnet
}

output "id_nsg" {
  value = module.vnet.id_nsg
}

output "name_nsg" {
  value = module.vnet.name_nsg
}


output "my_ip" {
  value = var.my_ip
}
