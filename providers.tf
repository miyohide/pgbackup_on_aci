terraform {
  require_version = ">= 1.0"

  require_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}
