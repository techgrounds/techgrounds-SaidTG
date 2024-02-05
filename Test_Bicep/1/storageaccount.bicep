@description('Specifies the location for resources.')
param location string = 'eastus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'mystorage232323232'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

