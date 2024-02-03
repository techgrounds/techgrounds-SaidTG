
param location string = 'westeurope'
param vNetWebName string = 'vNetWeb'
param subNetWebName string = 'subNetWebVM'
param nsgWebSub string = '/subscriptions/cf93fb64-f800-4fc9-a2c1-a37d01b31869/resourceGroups/ResourceGroup-V1.0/providers/Microsoft.Network/networkSecurityGroups/nsgWeb'
param nsgWebName string = 'nsgWeb'

// resource symbolic name should be unique within resource group
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

// Azure reserves the first four addresses and the last address, for a total of five IP addresses within each subnet
resource subNet4Web 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: vNet4Web
  name: subNetWebName
  properties: {
    addressPrefix: '10.10.10.128/25'
    networkSecurityGroup: {
      id: nsgWebSub
    }
  }
}

// Find out the resourceID of NSG and turn it into a param, use that param as the 'id:' to connect to subnet
resource nsg4web 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgWebName
  location: location 
}
