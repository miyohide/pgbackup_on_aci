terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "local" {
    path = "../99_tfstate/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
