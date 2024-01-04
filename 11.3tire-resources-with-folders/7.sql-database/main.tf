resource "azurerm_sql_database" "example" {
  name                = "myexamplesqldatabase"
  resource_group_name = "todoapprg"
  location            = "West US"
  server_name         = "yugsqlserver"

  tags = {
    environment = "staging"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}