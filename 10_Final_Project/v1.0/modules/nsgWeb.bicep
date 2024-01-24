
param location string 
param nsgWebName string 

resource nsg4Web 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgWebName
  location: location
}
