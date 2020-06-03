provider "azurerm" {
    version = "2.5.0"
    features {}

}

resource "azurerm_resource_group" "main" {
    name = "tfmainrg"
    location = "Australia East"
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
        image           = "tazeemn/weatherapi:${var.imagebuild}"
            cpu         = "1"
            memory      = "1"

            ports {
                port        = 80
                protocol    = "tcp"
            }
    }
}
