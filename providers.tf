#specifies provider configurations for the providers being used in this project
provider "azurerm" {
  features {}
  subscription_id = "xxxxxx-xxxxxxxxxx-xxxxxxxx-xxxxxxx-x"
  tenant_id       = "xxxxxx-xxxxxxxxxx-xxxxxxxx-xxxxxxx-x"
  client_id       = "xxxxxx-xxxxxxxxxx-xxxxxxxx-xxxxxxx-x"
  client_secret   = "xxxxxx-xxxxxxxxxx-xxxxxxxx-xxxxxxx-x"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }
}
