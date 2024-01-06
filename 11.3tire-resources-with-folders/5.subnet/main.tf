resource "azurerm_subnet" "yogeshsubnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnet
  address_prefixes     = each.value.address_prefixes
}


resource "azurerm_subnet" "subnet_bastion" {
  name                 = "subnet_bastion"
  resource_group_name  = "yugtodoapprg"
  virtual_network_name = "todo-vn"
  address_prefixes     = ["10.0.4.0/24"]
}
