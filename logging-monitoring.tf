
#resource "random_id" "log_analytics_workspace_name_suffix" {
#  byte_length = 8
#}

resource "azurerm_log_analytics_workspace" "default" {
  name                = var.log_analytics_workspace_name
  location            = var.azure_region
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = 30
}

resource "azurerm_application_insights" "example" {
  name                = var.azurerm_application_insights_name
  location            = var.azure_region
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.default.id
  application_type    = "web"
}

resource "azurerm_monitor_diagnostic_setting" "diag_setting_application_insights" {
  name                       = "diag_setting_application_insights"
  target_resource_id         = azurerm_application_insights.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.default.id

 log {
    category = "AppAvailabilityResults"
  }
  log {
    category = "AppBrowserTimings"
  }
  log {
    category = "AppMetrics"
  }
  log {
    category = "AppDependencies"
  }
  log {
    category = "AppExceptions"
  }
  log {
    category = "AppPageViews"
  }
  log {
    category = "AppPerformanceCounters"
  }
  log {
    category = "AppRequests"
  }
  log {
    category = "AppSystemEvents"
  }  
  log {
    category = "AppTraces"
  }
  log {
    category = "AppEvents"
  }
  
  metric {
    category = "AllMetrics"
  }
}

output "instrumentation_key" {
  value = azurerm_application_insights.example.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.example.app_id
}

resource "azurerm_monitor_diagnostic_setting" "diag_setting_postgresqldb" {
  name                       = "diag_setting_postgresqldb"
  target_resource_id         = azurerm_postgresql_server.aps.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.default.id

  log {
    category = "PostgreSQLLogs"
  }
  log {
    category = "QueryStoreRuntimeStatistics"
  }
  log {
    category = "QueryStoreWaitStatistics"
  }
  metric {
    category = "AllMetrics"
  }
}


# acr logging here
resource "azurerm_monitor_diagnostic_setting" "diag_setting_acr" {
  name                       = "diag_setting_acr"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.default.id

  log {
    category = "ContainerRegistryRepositoryEvents"
  }
  log {
    category = "ContainerRegistryLoginEvents"
  }

  metric {
    category = "AllMetrics"
  }
}

# ContainerInsights logging here

resource "azurerm_log_analytics_solution" "ContainerInsights" {
  solution_name         = "ContainerInsights"
  location              = var.azure_region
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.default.id
  workspace_name        = azurerm_log_analytics_workspace.default.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

# k8s logging here
resource "azurerm_monitor_diagnostic_setting" "diag_setting_aks" {
  name                       = "diag_setting_aks"
  target_resource_id         = azurerm_kubernetes_cluster.aks1.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.default.id

  log {
    category = "kube-apiserver"
  }
  log {
    category = "cloud-controller-manager"
  }
  log {
    category = "cluster-autoscaler"
  }
  log {
    category = "guard"
  }
  log {
    category = "kube-apiserver"
  }
  log {
    category = "kube-audit"
  }
  log {
    category = "kube-audit-admin"
  }
  log {
    category = "kube-controller-manager"
  }
  log {
    category = "kube-scheduler"
  }

  metric {
    category = "AllMetrics"
  }
}
