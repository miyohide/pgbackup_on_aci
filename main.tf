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

resource "azurerm_storage_account" "main" {
  name                     = "st${var.prefix}${random_string.name.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "main" {
  name                 = "aci-share"
  storage_account_name = azurerm_storage_account.main.name
  quota                = 5
}

resource "azurerm_container_group" "main" {
  name                = "aci-${var.prefix}-name"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "Public"
  dns_name_label      = "aci${var.prefix}name${random_string.name.result}"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "seanmckenna/aci-hellofiles"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 80
      protocol = "TCP"
    }

    volume {
      name       = "logs"
      mount_path = "/aci/logs"
      read_only  = false
      share_name = azurerm_storage_share.main.name

      storage_account_name = azurerm_storage_account.main.name
      storage_account_key  = azurerm_storage_account.main.primary_access_key
    }
  }
}

resource "azurerm_postgresql_flexible_server" "pg" {
  name = "pg-${var.prefix}-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  version = "13"
  administrator_login = var.postgresql_admin
  administrator_password = var.postgresql_password
  zone = "1"
  storage_mb = 32768
  sku_name = "B_Standard_B1ms"
}
