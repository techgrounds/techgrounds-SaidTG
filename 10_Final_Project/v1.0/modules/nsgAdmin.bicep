
param location string
param nsgAdminName string

resource nsg4Admin 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgAdminName
  location: location
}
