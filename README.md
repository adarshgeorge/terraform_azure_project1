# Infrastucture building in Azure using Terraform

**Create Storage Account to keep the terraform statefile in centrelly accessed for assigned user**


Mentioned the created storage accoutname in the settings.ini. 
```
[ec2-user@ip-172-31-4-240 terraform]$ cd dev/
[ec2-user@ip-172-31-4-240 dev]$ ll
total 8
-rw-rw-r-- 1 ec2-user ec2-user 1968 Sep  4 13:47 init.sh
-rw-rw-r-- 1 ec2-user ec2-user   95 Sep  5 13:03 settings.ini
drwxrwxr-x 3 ec2-user ec2-user   88 Sep  6 12:12 vnet
[ec2-user@ip-172-31-4-240 dev]$ cat settings.ini
storage_account_name=terraformstorage0172
container_name=statefiles
project_to_init_list=vnet
```

![alt HelloWorld](https://raw.githubusercontent.com/adarshgeorge/adarshgeorge/terraform_azure_project1/master/png/storage.png)

