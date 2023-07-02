terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my-rg" {
  name     = "my-resources"
  location = "West Europe"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "my-vn" {
  name                = "my-network"
  resource_group_name = azurerm_resource_group.my-rg.name
  location            = azurerm_resource_group.my-rg.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "my-subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.my-rg.name
  virtual_network_name = azurerm_virtual_network.my-vn.name
  address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "my-sg" {
  name                = "my-sg"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "my-dev-rule" {
  name                        = "my-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my-rg.name
  network_security_group_name = azurerm_network_security_group.my-sg.name
}

resource "azurerm_subnet_network_security_group_association" "my-sga" {
  subnet_id                 = azurerm_subnet.my-subnet.id
  network_security_group_id = azurerm_network_security_group.my-sg.id
}

resource "azurerm_public_ip" "my-ip" {
  name                = "my-ip"
  resource_group_name = azurerm_resource_group.my-rg.name
  location            = azurerm_resource_group.my-rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "my-nic" {
  name                = "my-nic"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.my-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my-ip.id
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_linux_virtual_machine" "my-vm" {
  name                = "my-vm"
  resource_group_name = azurerm_resource_group.my-rg.name
  location            = azurerm_resource_group.my-rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"

  custom_data = filebase64("customdata.tpl")

  network_interface_ids = [
    azurerm_network_interface.my-nic.id,
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-script.tpl", {
      hostname     = self.public_ip_address,
      user         = "adminuser",
      identityfile = "~/.ssh/id_rsa"
    })
    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }

  tags = {
    environment = "dev"
  }
}

data "azurerm_public_ip" "my-ip-data" {
  name                = azurerm_public_ip.my-ip.name
  resource_group_name = azurerm_resource_group.my-rg.name
}

output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.my-vm.name}: ${data.azurerm_public_ip.my-ip-data.ip_address}"
}
