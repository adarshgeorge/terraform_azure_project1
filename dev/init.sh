#!/bin/bash
# Description: Init all the terraform project of Lendico's project with a remote shared file and a lock

# Note that ARM_ACCESS_KEY is a fixed value by terraform at the moment, the binary will look automatically for the env var ARM_ACCESS_KEY
storage_auth_env_var="ARM_ACCESS_KEY"
settings_file="settings.ini"

# Retrieving the storage account and the container names, list of tf projects to init
dir=$(pwd)/$(dirname "${BASH_SOURCE[0]}")


# Check if the file exists

[ ! -f ${dir}/settings.ini ] && >&2 echo "${dir}/settings.ini not found" && exit 1

# setting up variables to store state files

storage_account_name=$(grep "storage_account_name=" ${dir}/settings.ini | sed 's/storage_account_name=\(.*\)/\1/g')
container_name=$(grep "container_name=" ${dir}/settings.ini | sed 's/container_name=\(.*\)/\1/g')
project_to_init_list=$(grep "project_to_init_list=" ${dir}/settings.ini | sed 's/project_to_init_list=\(.*\)/\1/g')

# Check if the storage account, container variables and tf projects are set
[ -z "$storage_account_name" ] && >&2 echo "storage_account_name not set in the settings.ini file" && exit 1
[ -z "$container_name" ] && >&2 echo "container_name not set in the settings.ini file" && exit 1
[ -z "$project_to_init_list" ] && >&2 echo "project_to_init_list not set in the settings.ini file" && exit 1

# Retrieving the secret key to access storage
access_key=$(env | grep $(echo $storage_auth_env_var) | sed "s/$storage_auth_env_var=\(.*\)/\1/g")

# Check if the access_key variable is set
[ -z "$access_key" ] && >&2 echo "access_key not set, check your environment variable $storage_auth_env_var" && exit 1

IFS=' ' read -r -a project_to_init_list <<< "$project_to_init_list"

for project in "${project_to_init_list[@]}"
do
  cd ${dir}/${project}
  terraform init -backend-config="storage_account_name=$storage_account_name" -backend-config="container_name=$container_name" -backend-config="key=$(basename $project)-test.tfstate"
done
