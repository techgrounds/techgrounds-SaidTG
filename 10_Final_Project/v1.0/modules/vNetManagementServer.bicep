
param location string = 'westeurope'

//resource symbolic name should be unique within resource group
resource vNetManagement 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'vNetManagementServer'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
  }
}
