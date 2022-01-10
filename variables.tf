variable "azure_region" {
  description = "Azure region"
  type = string
}

variable "resource_group_name" {
  description = "resource group name"
  type = string
}

variable "dbservername" {
  description = "Postgresql Database servername"
  type = string
}

variable "prod_database" {
  description = "Prod Postgresql database name"
  type = string
}

variable "dev_database" {
  description = " Dev Postgresql database name"
  type = string
}

variable "DB_ADMIN" {
  description = "admin for Postgresql"
  type = string
}

variable "DB_PASSWORD" {
  description = "Password for Postgresql admin (get from environment)"
  type = string
}

variable "container_registry_name" {
  description = "Container Registry name"
  type = string
}

variable "azurerm_kubernetes_cluster_name" {
  description = "AKS clustername"
  type = string
}

variable "log_analytics_workspace_name" {
  description = "log analytics workspace name"
  type = string
}

variable "log_analytics_workspace_sku" {
  description = "log analytics workspace SKU"
  type = string
}

variable "azurerm_application_insights_name" {
  description = "azurerm application insights name"
  type = string
}
