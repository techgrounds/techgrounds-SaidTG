
param location string = 'uksouth'
param vnetWebName string = 'vnetWeb'
param vnetAddressPrefix string = '10.20.20.0/24'
param subnetWebName string = 'subnetWeb'
param subnetAddressPrefix string = '10.20.20.128/25'

resource vnetWeb 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetWebName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetWebName
        properties: {
          addressPrefix: subnetAddressPrefix
          networkSecurityGroup: {
            id: 
          }
        }
      }
    ]
  }
}
