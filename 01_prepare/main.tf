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
