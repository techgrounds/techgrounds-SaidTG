
param location string = 'westeurope'

@description('The unique name of the storage account. This is used to ensure that resource names are unique.')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'v1${uniqueString(resourceGroup().id)}'

// Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only,
// Your storage account name must be unique within Azure.

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
