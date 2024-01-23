
param location string = 'westeurope'

//resource symbolic name should be unique within resource group
resource vNetWeb 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'vNetWebServer' 
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
  }
}
