output "kube_config" {
    value = azurerm_kubernetes_cluster.aks1.kube_config_raw
    sensitive = true
}

output "AKShost" {
    value = azurerm_kubernetes_cluster.aks1.kube_config.0.host
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "DB_server_name" {
  value = azurerm_postgresql_server.aps.fqdn
}

output "instrumentation_key" {
  value = azurerm_application_insights.example.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.example.app_id
}

