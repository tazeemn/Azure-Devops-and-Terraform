provider "azurerm" {
    version = "2.5.0"
    features {}

}

terraform {
    backend "azurerm" {
        resource_group_name     = "tf_rg_blobstore"
        storage_account_name    = "tfstoragetazeem"
        container_name          = "tfstate"
        key                     = "terraform.tfstate"
    }
}
resource "azurerm_resource_group" "main" {
    name = "tfmainrg"
    location = "Australia East"
}
variable "imagebuild" {
    type        = string 
    description = "Latest image build"
}
resource "azurerm_container_group" "tfcg_test" {
    name                = "weatherapi"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    ip_address_type     = "public"
    dns_name_label      = "tazeem-tftest"
    os_type             = "Linux"

    container {
        name            = "weatherapi"
        image           = "tazeem/weatherapi:${var.imagebuild}"
            cpu         = "1"
            memory      = "1"

            ports {
                port        = 80
                protocol    = "TCP"
            }
    }
}



