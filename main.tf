resource "azurerm_resource_group" "main" {
  name     = "rg-${var.prefix}-pgbackup"
  location = var.location
}

resource "random_string" "name" {
  length  = 4
  upper   = false
  lower   = true
  special = false
}

resource "azurerm_container_group" "main" {
  name                = "aci-${var.prefix}-name"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "None"
  os_type             = "Linux"
  restart_policy      = "Never"

  container {
    name     = "postgres"
    image    = "postgres:13"
    cpu      = "0.5"
    memory   = "1.0"
    commands = ["pg_dump"]
    secure_environment_variables = {
      PGHOST     = azurerm_postgresql_flexible_server.main.fqdn
      PGDATABASE = var.postgresql_database
      PGUSER     = var.postgresql_admin
      PGPASSWORD = var.postgresql_password
    }

    # volume {
    #   name       = "logs"
    #   mount_path = "/aci/logs"
    #   read_only  = false
    #   share_name = azurerm_storage_share.main.name

    #   storage_account_name = azurerm_storage_account.main.name
    #   storage_account_key  = azurerm_storage_account.main.primary_access_key
    # }
  }
}
