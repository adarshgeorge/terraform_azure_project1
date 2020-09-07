# Infrastucture building in Azure using Terraform

**Create Storage Account to keep the terraform statefile in centrelly accessed for assigned user**

- Create storage account in any location
- Create container with name **statefiles**
- Copy the container Access Key and export as env variable as ARM_ACCESS_KEY in .bashrc
- 

```
$ tree terraform/
terraform/
├── dev
│   ├── init.sh
│   ├── settings.ini
│   └── vnet
│       ├── main.tf
│       ├── output.tf
│       └── vars.tf
├── modules
│   └── vnet
│       ├── nsg_orgtfbk
│       ├── nsg.tf
│       ├── output.tf
│       ├── pub_ip.tf
│       ├── resource_group.tf
│       ├── subnet.tf
│       ├── vars.tf
│       ├── vm1.tf
│       ├── vm2.tf
│       └── vnet.tf
├── png
│   ├── ARM.png
│   ├── state_file.png
│   ├── storage1.png
│   └── test.txt
└── README.md

5 directories, 20 files
```

Mention the created storage_accout_name and container_name in the settings.ini. 

In the section project_to_init_list we need to specify the directories name seperate with space that we want to initilize terraform. 

```
[ec2-user@ip-172-31-4-240 dev]$ cat settings.ini
storage_account_name=terraformstorage0172
container_name=statefiles
project_to_init_list=vnet
```

Register an App with name terraform_azure_app in Active Directory.

- Copy the client id and export it as TF_VAR_client_id in .bashrc

- Then go to subcription >> IAM and add roles to the create app.
- Create client secret key from Certificates & secrets
- Copy the client secret and export it as TF_VAR_client_secret in .bashrc

Source .bachrc
```
$ source .bashrc
```

Copy and mention the subcription id and tenent id in vars.tf

```
vi terraform/dev/vnet/vars.tf
```

Now wee need to Initialize

```

$ cd terraform/dev/vnet/
$ ls
main.tf  output.tf  vars.tf

$ cd ..
[ec2-user@ip-172-31-4-240 dev]$ ll
total 8
-rw-rw-r-- 1 ec2-user ec2-user 1968 Sep  4 13:47 init.sh
-rw-rw-r-- 1 ec2-user ec2-user   95 Sep  5 13:03 settings.ini
drwxrwxr-x 2 ec2-user ec2-user   53 Sep  6 13:50 vnet
$ vi settings.ini
$
$ cat settings.ini
storage_account_name=terraformstorage0172
container_name=statefiles
project_to_init_list=vnet
$
$ source init.sh
Initializing modules...
- vnet in ../../modules/vnet

Initializing the backend...

Successfully configured the backend "azurerm"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "2.24.0"...
- Installing hashicorp/azurerm v2.24.0...
- Installed hashicorp/azurerm v2.24.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
$
```

Now execute 
```
$ terraform plan
Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

module.vnet.azurerm_resource_group.resource_group: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg]
module.vnet.azurerm_virtual_network.vnet: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet]
module.vnet.azurerm_subnet.private: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet/subnets/subnet-priv]
module.vnet.azurerm_network_interface.private: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkInterfaces/nic2]
module.vnet.azurerm_virtual_machine.private: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Compute/virtualMachines/vm2]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vnet.azurerm_network_interface.private will be created
  + resource "azurerm_network_interface" "private" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "northeurope"
      + mac_address                   = (known after apply)
      + name                          = "nic2"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "terraform_rg"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "ipconfig2"
          + primary                       = (known after apply)
          + private_ip_address            = "10.0.3.5"
          + private_ip_address_allocation = "static"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # module.vnet.azurerm_network_interface.public will be created
  + resource "azurerm_network_interface" "public" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "northeurope"
      + mac_address                   = (known after apply)
      + name                          = "nic1"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "terraform_rg"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "ipconfig1"
          + primary                       = (known after apply)
          + private_ip_address            = "10.0.2.5"
          + private_ip_address_allocation = "static"
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + subnet_id                     = (known after apply)
        }
    }

  # module.vnet.azurerm_network_security_group.nsg will be created
  + resource "azurerm_network_security_group" "nsg" {
      + id                  = (known after apply)
      + location            = "northeurope"
      + name                = "vnet-nsg"
      + resource_group_name = "terraform_rg"
      + security_rule       = (known after apply)
    }

  # module.vnet.azurerm_network_security_group.nsg1 will be created
  + resource "azurerm_network_security_group" "nsg1" {
      + id                  = (known after apply)
      + location            = "northeurope"
      + name                = "vm2-nsg"
      + resource_group_name = "terraform_rg"
      + security_rule       = (known after apply)
    }

  # module.vnet.azurerm_network_security_rule.allow_myip will be created
  + resource "azurerm_network_security_rule" "allow_myip" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "allow_myip"
      + network_security_group_name = "vnet-nsg"
      + priority                    = 110
      + protocol                    = "*"
      + resource_group_name         = "terraform_rg"
      + source_address_prefix       = "103.148.21.226"
      + source_port_range           = "*"
    }

  # module.vnet.azurerm_network_security_rule.allow_web_ip will be created
  + resource "azurerm_network_security_rule" "allow_web_ip" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "3306"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "allow_web_ip"
      + network_security_group_name = "vm2-nsg"
      + priority                    = 100
      + protocol                    = "*"
      + resource_group_name         = "terraform_rg"
      + source_address_prefix       = "10.0.2.5"
      + source_port_range           = "3306"
    }

  # module.vnet.azurerm_public_ip.vm_pub_ip will be created
  + resource "azurerm_public_ip" "vm_pub_ip" {
      + allocation_method       = "Dynamic"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 30
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "northeurope"
      + name                    = "pubip1"
      + resource_group_name     = "terraform_rg"
      + sku                     = "Basic"
    }

  # module.vnet.azurerm_resource_group.resource_group will be created
  + resource "azurerm_resource_group" "resource_group" {
      + id       = (known after apply)
      + location = "northeurope"
      + name     = "terraform_rg"
    }

  # module.vnet.azurerm_subnet.private will be created
  + resource "azurerm_subnet" "private" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.3.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subnet-priv"
      + resource_group_name                            = "terraform_rg"
      + virtual_network_name                           = "ter-vnet"
    }

  # module.vnet.azurerm_subnet.public will be created
  + resource "azurerm_subnet" "public" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.2.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subnet-pub"
      + resource_group_name                            = "terraform_rg"
      + virtual_network_name                           = "ter-vnet"
    }

  # module.vnet.azurerm_subnet_network_security_group_association.nsg1_subnet_association will be created
  + resource "azurerm_subnet_network_security_group_association" "nsg1_subnet_association" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.vnet.azurerm_subnet_network_security_group_association.nsg_subnet_association will be created
  + resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.vnet.azurerm_virtual_machine.private will be created
  + resource "azurerm_virtual_machine" "private" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = true
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "northeurope"
      + name                             = "vm2"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "terraform_rg"
      + vm_size                          = "Standard_B2s"

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }

      + os_profile {
          + admin_password = (sensitive value)
          + admin_username = "azureuser"
          + computer_name  = "vm2"
          + custom_data    = (known after apply)
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_data_disk {
          + caching                   = (known after apply)
          + create_option             = (known after apply)
          + disk_size_gb              = (known after apply)
          + lun                       = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = (known after apply)
          + name                      = (known after apply)
          + vhd_uri                   = (known after apply)
          + write_accelerator_enabled = (known after apply)
        }

      + storage_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "OsDisk2"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.vnet.azurerm_virtual_machine.public will be created
  + resource "azurerm_virtual_machine" "public" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = true
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "northeurope"
      + name                             = "vm1"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "terraform_rg"
      + vm_size                          = "Standard_B2s"

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }

      + os_profile {
          + admin_password = (sensitive value)
          + admin_username = "azureuser"
          + computer_name  = "vm1"
          + custom_data    = (known after apply)
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_data_disk {
          + caching                   = (known after apply)
          + create_option             = (known after apply)
          + disk_size_gb              = (known after apply)
          + lun                       = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = (known after apply)
          + name                      = (known after apply)
          + vhd_uri                   = (known after apply)
          + write_accelerator_enabled = (known after apply)
        }

      + storage_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "OsDisk1"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.vnet.azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "northeurope"
      + name                = "ter-vnet"
      + resource_group_name = "terraform_rg"
      + subnet              = (known after apply)
    }

Plan: 15 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + address_space           = [
      + "10.0.0.0/16",
    ]
  + id_nsg                  = (known after apply)
  + id_resource_group       = (known after apply)
  + id_vnet                 = (known after apply)
  + location_resource_group = "northeurope"
  + my_ip                   = "103.148.21.226"
  + name_nsg                = "vnet-nsg"
  + name_resource_group     = "terraform_rg"
  + name_vnet               = "ter-vnet"

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

Finally execute the below command 
```
[ec2-user@ip-172-31-4-240 vnet]$ terraform apply -auto-approve
module.vnet.azurerm_resource_group.resource_group: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg]
module.vnet.azurerm_virtual_network.vnet: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet]
module.vnet.azurerm_subnet.private: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet/subnets/subnet-priv]
module.vnet.azurerm_network_interface.private: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkInterfaces/nic2]
module.vnet.azurerm_virtual_machine.private: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Compute/virtualMachines/vm2]
module.vnet.azurerm_resource_group.resource_group: Creating...
module.vnet.azurerm_resource_group.resource_group: Creation complete after 2s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg]
module.vnet.azurerm_network_security_group.nsg: Creating...
module.vnet.azurerm_network_security_group.nsg1: Creating...
module.vnet.azurerm_virtual_network.vnet: Creating...
module.vnet.azurerm_public_ip.vm_pub_ip: Creating...
module.vnet.azurerm_network_security_group.nsg: Creation complete after 8s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkSecurityGroups/vnet-nsg]
module.vnet.azurerm_network_security_rule.allow_myip: Creating...
module.vnet.azurerm_public_ip.vm_pub_ip: Creation complete after 8s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/publicIPAddresses/pubip1]
module.vnet.azurerm_network_security_group.nsg1: Creation complete after 8s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkSecurityGroups/vm2-nsg]
module.vnet.azurerm_network_security_rule.allow_web_ip: Creating...
module.vnet.azurerm_network_security_rule.allow_myip: Creation complete after 2s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkSecurityGroups/vnet-nsg/securityRules/allow_myip]
module.vnet.azurerm_virtual_network.vnet: Still creating... [10s elapsed]
module.vnet.azurerm_network_security_rule.allow_web_ip: Creation complete after 3s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkSecurityGroups/vm2-nsg/securityRules/allow_web_ip]
module.vnet.azurerm_virtual_network.vnet: Creation complete after 16s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet]
module.vnet.azurerm_subnet.private: Creating...
module.vnet.azurerm_subnet.public: Creating...
module.vnet.azurerm_subnet.private: Creation complete after 2s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet/subnets/subnet-priv]
module.vnet.azurerm_subnet_network_security_group_association.nsg1_subnet_association: Creating...
module.vnet.azurerm_network_interface.private: Creating...
module.vnet.azurerm_subnet.public: Creation complete after 5s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet/subnets/subnet-pub]
module.vnet.azurerm_network_interface.public: Creating...
module.vnet.azurerm_subnet_network_security_group_association.nsg_subnet_association: Creating...
module.vnet.azurerm_subnet_network_security_group_association.nsg1_subnet_association: Creation complete after 5s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet/subnets/subnet-priv]
module.vnet.azurerm_subnet_network_security_group_association.nsg_subnet_association: Creation complete after 5s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet/subnets/subnet-pub]
module.vnet.azurerm_network_interface.private: Still creating... [10s elapsed]
module.vnet.azurerm_network_interface.public: Still creating... [10s elapsed]
module.vnet.azurerm_network_interface.private: Creation complete after 14s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkInterfaces/nic2]
module.vnet.azurerm_virtual_machine.private: Creating...
module.vnet.azurerm_network_interface.public: Creation complete after 14s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkInterfaces/nic1]
module.vnet.azurerm_virtual_machine.public: Creating...
module.vnet.azurerm_virtual_machine.private: Still creating... [10s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [10s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [20s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [20s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [30s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [30s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [40s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [40s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [50s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [50s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [1m0s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [1m0s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [1m10s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [1m10s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [1m20s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [1m20s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [1m30s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [1m30s elapsed]
module.vnet.azurerm_virtual_machine.private: Still creating... [1m40s elapsed]
module.vnet.azurerm_virtual_machine.public: Still creating... [1m40s elapsed]
module.vnet.azurerm_virtual_machine.private: Creation complete after 1m44s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Compute/virtualMachines/vm2]
module.vnet.azurerm_virtual_machine.public: Creation complete after 1m42s [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Compute/virtualMachines/vm1]

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

address_space = [
  "10.0.0.0/16",
]
id_nsg = /subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkSecurityGroups/vnet-nsg
id_resource_group = /subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg
id_vnet = /subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet
location_resource_group = northeurope
my_ip = 103.148.21.226
name_nsg = vnet-nsg
name_resource_group = terraform_rg
name_vnet = ter-vnet
[
```

**Login details of VM1**

Obtain the Public IP of the VM1 from Terraform server.
```
$ az vm list-ip-addresses |grep vm1 -A 10 |grep ipAddress |awk {'print $2'}
"52.178.201.46",
$
```


Obtain Username and Password of the VM2 from from Terraform server.


**Login details of VM2**
```
C:\Users\Root>ssh azureuser@52.178.201.46
The authenticity of host '52.178.201.46 (52.178.201.46)' can't be established.
ECDSA key fingerprint is SHA256:r2S55dhVh/ACnWn6Os/MpEmubvgaSY3xAbVoH7cuEYw.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '52.178.201.46' (ECDSA) to the list of known hosts.
azureuser@52.178.201.46's password:


To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@vm1:~$ sudo -i
root@vm1:~#o -i
root@vm1:~#
```
SSH from VM1 to VM2
```
root@vm1:~# ssh azureuser@10.0.3.5
azureuser@10.0.3.5's password:
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 5.4.0-1023-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Sep  7 08:13:01 UTC 2020

  System load:  0.31              Processes:           131
  Usage of /:   4.4% of 28.90GB   Users logged in:     0
  Memory usage: 5%                IP address for eth0: 10.0.3.5
  Swap usage:   0%

0 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@vm2:~$ sudo -i
root@vm2:~#
```

MySQL connection from VM1 to VM2
```
root@vm1:~# telnet 10.0.3.5 3306
Trying 10.0.3.5...
Connected to 10.0.3.5.
Escape character is '^]'.

root@vm1:~# mysql -u azure -p -h 10.0.3.5 -P 3306
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.7.31-0ubuntu0.18.04.1 (Ubuntu)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```
Done!


To remove the infra

```
$ terraform destroy
Acquiring state lock. This may take a few moments...
module.vnet.azurerm_resource_group.resource_group: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg]
module.vnet.azurerm_virtual_network.vnet: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/virtualNetworks/ter-vnet]
module.vnet.azurerm_network_security_group.nsg1: Refreshing state... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg/providers/Microsoft.Network/networkSecurityGroups/vm2-nsg]
-
-
-
module.vnet.azurerm_resource_group.resource_group: Still destroying... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg, 40s elapsed]
module.vnet.azurerm_resource_group.resource_group: Still destroying... [id=/subscriptions/1b0a362f-2b27-4d41-a889-14b3ac922fed/resourceGroups/terraform_rg, 50s elapsed]
module.vnet.azurerm_resource_group.resource_group: Destruction complete after 52s

Destroy complete! Resources: 15 destroyed.
[ec2-user@ip-172-31-4-240 vnet]$

```
**That's it**