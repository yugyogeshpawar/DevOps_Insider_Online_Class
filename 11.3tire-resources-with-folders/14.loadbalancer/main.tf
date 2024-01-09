resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = "East Us"
  resource_group_name = "yugtodoapprg"
  allocation_method   = "Static"
}


resource "azurerm_lb" "example" {
  name                = "todo-lb"
  resource_group_name = "yugtodoapprg"
  location            = "East Us"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_probe" "example" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.example.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}


resource "azurerm_lb_backend_address_pool" "example" {
  name            = "fronted-pool"
  loadbalancer_id = azurerm_lb.example.id
}

resource "azurerm_network_interface_backend_address_pool_association" "fronted1" {
  network_interface_id    = "/subscriptions/b46c125c-073e-4204-83e3-4c2eef053249/resourceGroups/yugtodoapprg/providers/Microsoft.Network/networkInterfaces/todo-nic"
  ip_configuration_name   = "fronted1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}

resource "azurerm_network_interface_backend_address_pool_association" "frontend2" {
  network_interface_id    = "/subscriptions/b46c125c-073e-4204-83e3-4c2eef053249/resourceGroups/yugtodoapprg/providers/Microsoft.Network/networkInterfaces/todo-backend-nic"
  ip_configuration_name   = "frontend2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "frontendRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.example.id]
  probe_id                       = azurerm_lb_probe.example.id
}
