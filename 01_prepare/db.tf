# PostgreSQLを作成する
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = "pg-${var.prefix}-${random_string.name.result}"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  version                = "13"
  administrator_login    = var.postgresql_admin
  administrator_password = var.postgresql_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = var.postgresql_database
  server_id = azurerm_postgresql_flexible_server.main.id
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "main" {
  name                = "allowazure1"
  server_id           = azurerm_postgresql_flexible_server.main.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"  
}
