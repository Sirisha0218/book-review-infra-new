resource "azurerm_resource_group" "rg" {
  name     = "${var.application_name}-${var.environment}-rg"
  location = var.location
}

module "network" {
  source                         = "./modules/network"
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = var.location
  application_name               = var.application_name
  environment                    = var.environment
  vnet_address_space             = var.vnet_address_space
  public_subnet_address_prefixes = var.public_subnet_address_prefixes
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vnet_subnet_id      = module.network.public_subnet_id
  application_name    = var.application_name
  environment         = var.environment
  vm_size             = var.vm_size
  ssh_public_key      = var.ssh_public_key
}

module "database" {
  source = "./modules/database"

  mysql_admin_username = "mysqladmin"
  mysql_admin_password = "SuperSecret123!"
  mysql_database_name  = "bookreviews_dev"
  backend_vm_public_ip = var.backend_vm_public_ip
}


