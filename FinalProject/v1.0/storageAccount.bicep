
// storage account

param location string = resourceGroup().location

@description('select an environment type for deployment')
@allowed([
  'dev'
  'prod'
])
param environmentType string = 'dev'

@description('The unique name of the storage account. This is used to ensure that resource names are unique.')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'stgacc${uniqueString(resourceGroup().id)}'

param containerName string = 'blobcontain'

param installWebServer string = 'installUbuntu'

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_ZRS' : 'Standard_LRS'

// storage account names must be unique in Azure and between 3 and 24 characters in length and may contain numbers and lowercase letters only.

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier:'Hot'
  }
  resource blobService 'blobServices' = {
    name: 'default'
    resource Container 'containers' = {
      name: containerName
    }
  }
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'postDeployScripts'
  location: location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.56.0'
    timeout: 'PT1H'
    retentionInterval: 'P1D'
    cleanupPreference: 'OnSuccess'
    storageAccountSettings: {
      storageAccountName: storageAccountName
      storageAccountKey: storageAccount.listKeys().keys[0].value
    }
    environmentVariables:[
      {
        name: 'Azure_Storage_Account'
        value: storageAccount.name
      }
      {
        name: 'Azure_Storage_Key'
        secureValue: storageAccount.listKeys().keys[0].value
      }
      {
        name: 'Content'
        value: loadTextContent('./scripts/installWeb.sh')
      }  
    ]
    scriptContent: 'echo "$Content" > ${installWebServer} && az storage blob upload -f ${installWebServer} -c ${containerName} -n ${containerName}'
  }
}

output storageName string = storageAccountName
output bloburl string = storageAccount.properties.primaryEndpoints.blob
