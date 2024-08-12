terraform {
  required_version = ">=1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.51, < 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }

backend "azurerm" {
    resource_group_name  = "k8s"   # Partial configuration, provided during "terraform init"
     storage_account_name = "k8stestbsi"   # Partial configuration, provided during "terraform init"
     container_name       = "k8stestbsi"   # Partial configuration, provided during "terraform init"
    key                  = "aksdemo"
  }
}


provider "azurerm" {
  features {
  client_id       = "e07067bb-36bd-4d36-956c-aff6ff7e667e"
  client_secret   = "hDJ8Q~zEcU~odczrZn2loKbupi2HxouiaoJ0IbOI"
  tenant_id       = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
  subscription_id = "346142f0-61a3-4c25-81bd-910e4027886a"
}

    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# DO NOT DO THIS IN PRODUCTION ENVIRONMENT
provider "kubernetes" {
  host                   = module.aks.admin_host
  client_certificate     = base64decode(module.aks.admin_client_certificate)
  client_key             = base64decode(module.aks.admin_client_key)
  cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
}

provider "random" {}
