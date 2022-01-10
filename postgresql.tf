resource "azurerm_postgresql_server" "aps" {
  name                = var.dbservername
  location            = var.azure_region
  resource_group_name = var.resource_group_name
  sku_name = "B_Gen5_1"

  storage_profile {
 storage_mb = 5120
 backup_retention_days = 7
 geo_redundant_backup = "Disabled"
  }

  administrator_login = var.DB_ADMIN
  #TODO  - password needs to be changed to be taken from secret file
  administrator_login_password = var.DB_PASSWORD
  version = "11"
  ssl_enforcement = "Disabled"
  public_network_access_enabled = true

}

resource "azurerm_postgresql_database" "proddb" {
  name = var.prod_database
  resource_group_name = var.resource_group_name
  server_name = var.dbservername
  charset = "UTF8"
  collation = "English_United States.1252"
  depends_on = [azurerm_postgresql_server.aps]
}

resource "azurerm_postgresql_database" "devdb" {
  name = var.dev_database
  resource_group_name = var.resource_group_name
  server_name = var.dbservername
  charset = "UTF8"
  collation = "English_United States.1252"
  depends_on = [azurerm_postgresql_server.aps]
}


#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_firewall_rule
#The Azure feature Allow access to Azure services can be enabled by setting start_ip_address and end_ip_address to 0.0.0.0 which (is documented in the Azure API Docs).

 resource "azurerm_postgresql_firewall_rule" "db_firewall_rule" {
  name                = "permit-azure"
  resource_group_name = azurerm_postgresql_server.aps.resource_group_name
  server_name         = azurerm_postgresql_server.aps.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
  
} 

