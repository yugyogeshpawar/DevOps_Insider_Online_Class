resource "azurerm_resource_group" "resourcegroups" {
  for_each = var.rgs
  name     = each.value.name
  location = each.value.location
}
