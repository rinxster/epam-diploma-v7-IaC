# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"


# option to store tfstate file in Azure
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-westeurope"
    storage_account_name = "csb10032000521bd20e"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}



provider "azurerm" {
  features {}
}
