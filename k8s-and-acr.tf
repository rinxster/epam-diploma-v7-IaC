# AKS Cluster

#provider "kubernetes" {
  #config_context = "minikube"
#}


resource "azurerm_kubernetes_cluster" "aks1" {
  name                = var.azurerm_kubernetes_cluster_name
  location            = var.azure_region
  resource_group_name = var.resource_group_name
  dns_prefix          = var.azurerm_kubernetes_cluster_name

  

  default_node_pool {
    name = "default"
    node_count = 1
    min_count = 1
    max_count = 3
    vm_size = "Standard_B2s"
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled =  true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.default.id
    }
  }
  
  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" # CNI
  }
}


# Container registry
resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.azure_region
  sku                 = "Basic"
   admin_enabled       = true
}

# Allow AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_to_acr_role" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.aks1.kubelet_identity[0].object_id
}