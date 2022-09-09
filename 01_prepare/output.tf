output "postgres_server_name" {
  value = azurerm_postgresql_flexible_server.main.name
}

output "postgres_password" {
  value     = azurerm_postgresql_flexible_server.main.administrator_password
  sensitive = true
}
