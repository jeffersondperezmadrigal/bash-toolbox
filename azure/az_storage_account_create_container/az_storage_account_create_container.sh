#! /bin/bash

#
# This bash script creates a blob storage 
# container in Azure Storage Account.
# Jeffersond Perez Madrigal.
# 2021
#

## Variables

error_count=0
confirmation=false
resource_group_name=""
storage_account_name=""
container_name=""

## Validation

echo "[Starting validations]"

if [ -n "$1" ]; then
    resource_group_name=$1
    echo -e "\e[1;32m success: resource_group_name -> \e[0m" $resource_group_name
else
    let "error_count++"
    echo -e "\e[1;31m input_error: resource_group_name not found \e[0m"
fi

if [ -n "$2" ]; then
    storage_account_name=$2
    echo -e "\e[1;32m success: storage_account_name -> \e[0m" $storage_account_name
else
    let "error_count++"
    echo -e "\e[1;31m input_error: storage_account_name not found \e[0m"
fi

if [ -n "$3" ]; then
    container_name=$3
    echo -e "\e[1;32m success: container_name -> \e[0m" $container_name
else
    let "error_count++"
    echo -e "\e[1;31m input_error: container_name not found \e[0m"
    echo ""
fi

if [ $error_count -gt 0 ]; then
    exit 1
fi

## Main

echo "[Getting Storage Account Key]"

storage_account_key=$(az storage account keys list --resource-group $resource_group_name --account-name $storage_account_name --query [0].value -o tsv)

echo "[Creating Container]"

az storage container create --name $container_name --account-name $storage_account_name --account-key $storage_account_key

## Outputs

echo -e "\e[1;33m output: storage_account_name -> \e[0m" $storage_account_name
echo -e "\e[1;33m output: container_name -> \e[0m" $container_name
