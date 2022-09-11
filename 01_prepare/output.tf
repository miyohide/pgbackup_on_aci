output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "postgres_server_name" {
  value = azurerm_postgresql_flexible_server.main.name
}

output "postgres_password" {
  value     = azurerm_postgresql_flexible_server.main.administrator_password
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}
