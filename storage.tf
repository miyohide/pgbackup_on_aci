# ファイルなどを格納するStorageアカウントとFile Shareを作成する
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
