
param location string = 'westeurope'
param vNetWebName string = 'vNetWeb'
param subNetWebName string = 'subNetWebVM'
param nsgWebName string = 'nsgWeb1'

//resource symbolic name should be unique within resource group
resource vNet4Web 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: vNetWebName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
  }
}

//Azure reserves the first four addresses and the last address, for a total of five IP addresses within each subnet
resource subNet4Web 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: vNet4Web
  name: subNetWebName
  properties: {
    addressPrefix: '10.10.10.128/25'
    networkSecurityGroup: {
      
    }
  }
}

resource nsgWeb 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgWebName
  location: location 
} 
