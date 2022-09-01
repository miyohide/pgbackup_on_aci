resource "azurerm_resource_group" "main" {
  name = "rg-pgbackup"
  location = "japaneast"
}

resource "azurerm_container_group" "main" {
  name = "aciname"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type = "Public"
  dns_name_label = "aciname"
  os_type = "Linux"

  container {
    name = "hello-world"
    image = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu = "0.5"
    memory = "1.5"

    ports {
        port = 443
        protocol = "TCP"
    }
  }
}
