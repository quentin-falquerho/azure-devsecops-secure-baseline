variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "prefix" { type = string }

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Log Analytics Workspace for centralized security log management
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.prefix}-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Secure Key Vault (Soft delete enabled, purge protection, private network posture preferred)
resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.prefix}-${random_string.suffix.result}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  sku_name                    = "standard"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}
