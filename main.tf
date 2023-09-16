# specifies the resources which will be created/maintained

# create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    app    = "test byok poc"
    ticket = "TEST-1234"
  }
}

data "azurerm_client_config" "current" {}

# create an azure keyvault
resource "azurerm_key_vault" "kv" {
  name                = "cskeyvaulttest01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  enabled_for_disk_encryption   = true
  soft_delete_retention_days    = 90
  purge_protection_enabled      = true
  sku_name                      = "standard"
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "UnwrapKey",
      "WrapKey",
      "Get",
      "List",
      "Create",
      "Update",
      "Import"
    ]

  }

  tags = {
    app    = "test byok poc"
    ticket = "TEST-1234"
  }

}

# # create a key
# resource "azurerm_key_vault_key" "test-key" {
#   name         = "test-key"
#   key_vault_id = azurerm_key_vault.kv.id
#   key_type     = "RSA"
#   key_size     = 2048

#   key_opts = [
#     "unwrapKey",
#     "wrapKey",
#   ]

#   depends_on = [azurerm_key_vault.kv]
# }

# create azure postgresql
resource "azurerm_postgresql_server" "postgres" {
  name                = "cstestpoc-postgres01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = "20480"

  ssl_enforcement_enabled       = true
  public_network_access_enabled = true

  administrator_login          = "test_admin"
  administrator_login_password = "test_password123!"

  tags = {
    app    = "test byok poc"
    ticket = "TEST-1234"
  }
}
