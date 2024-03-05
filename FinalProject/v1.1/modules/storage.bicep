
param location string

//@description('select an environment type for deployment')
//@allowed([ 
  //'dev' 
  //'prod' 
//])
//param environmentType string = 'dev'

param storageSku string = 'Standard_LRS'
param storageKind string = 'StorageV2'

//storage account names must be unique in Azure and between 3 and 24 characters in length and may contain numbers and lowercase letters only.
@description('Name the storage acount with a unique name. As f.e. stg123xyz')
@minLength(3)
@maxLength(24)
param storageName string 

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageName
  location: location
  sku: {
    name: storageSku
  }
  kind: storageKind
  properties:{
    accessTier: 'Hot'
    allowBlobPublicAccess: true
     publicNetworkAccess: 'Enabled'
     minimumTlsVersion: 'TLS1_2'
     networkAcls:{
      defaultAction: 'Allow'
      }
  }
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
 parent: storageAccount
  name: 'default'
   properties: {  
   }
}

// Lowercase letters, numbers, and hyphens.//
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: blobservice
  name: 'pdscripts'
   properties: {
    publicAccess:'Blob'
   }      
}

output storageID string = storageAccount.id
