resource "azurerm_resource_group" "main" {
  name     = "rg-${var.prefix}-pgbackup"
  location = var.location
}

resource "random_string" "name" {
  length = 4
  upper = false
  lower = true
  special = false
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
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }
}
