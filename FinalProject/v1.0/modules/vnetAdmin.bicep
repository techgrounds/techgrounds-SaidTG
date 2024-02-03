
param location string = 'uksouth'
param vnetAdminName string = 'vnetAdmin'
param vnetAddressPrefix string = '10.10.10.0/24'
param subnetAdminName string = 'subnetAdmin'
param subnetAddressPrefix string = '10.10.10.128/25'

resource vnetAdmin 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetAdminName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetAdminName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

