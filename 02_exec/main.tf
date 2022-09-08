data "azurerm_resource_group" "main" {
  name = "rg-${var.prefix}-pgbackup"
}

data "azurerm_postgresql_flexible_server" "main" {
  name                = var.postgresql_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_storage_account" "main" {
  name = var.storage_account_name
}

resource "azurerm_container_group" "main" {
  name                = "aci-${var.prefix}-name"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
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
      PGHOST     = data.azurerm_postgresql_flexible_server.main.fqdn
      PGDATABASE = var.postgresql_database
      PGUSER     = data.azurerm_postgresql_flexible_server.main.administrator_login
      #      PGPASSWORD = data.azurerm_postgresql_flexible_server.main.administrator_password
    }

    volume {
      name       = "backups"
      mount_path = "/aci/backups"
      read_only  = false
      share_name = var.fileshare_name

      storage_account_name = data.azurerm_storage_account.main.name
      storage_account_key  = data.azurerm_storage_account.main.primary_access_key
    }
  }
}
