
param location string = 'westeurope'
param vNetAdminName string = 'vNetAdmin'
param subNetAdminName string = 'subNetAdminVM'
param nsgAdminName string = 'nsgAdmin'

//resource symbolic name should be unique within resource group
resource vNet4Admin 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: vNetAdminName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
  }
}

//Azure reserves the first four addresses and the last address, for a total of five IP addresses within each subnet
resource subNet4Admin 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: vNet4Admin
  name: subNetAdminName
  properties: {
    addressPrefix: '10.20.20.128/25'
  }
}

resource nsgAdmin 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgAdminName
  location: location
}
