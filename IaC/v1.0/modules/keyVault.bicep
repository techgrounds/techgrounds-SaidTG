
//The requirements for Key Vault names are: between 3 and 24 characters long. Alphanumerics and hyphens (dash).
//Start with a letter. End with a letter or digit. Can not contain consecutive hyphens. Key Vault names must be globally unique.

//@description('select an environment type for deployment')
//@allowed([
 // 'dev'
 // 'prod'
//])
//param environmentType string = 'dev'

param location string 

@description('The unique name of the Key Vault. uniqueString is used to ensure that resource names are unique.')
@minLength(3)
@maxLength(24) // change characters before $ sign as you wish.
param keyVaultName string = 'keyVault-${uniqueString(resourceGroup().id)}'

var tenantId = 'de60b253-74bd-4365-b598-b9e55a2b208d'
var objectId = '5e629060-8ed6-4f5d-bdf4-310d6c3bec21'

@description('Specifies the name of the secret that you want to create.') //Alphanumerics and hyphens only.
@secure()
param secretName1 string 

@description('Specifies the value of the secret that you want to create.')
@secure()
param secretValue1 string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: objectId
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          storage:[
            'all'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Deny'
      bypass:'AzureServices'
    }
  }
}

resource keyVaultSecret1 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: secretName1
  properties: {
    value: secretValue1
  }
}

//output keyVault12 string = keyVault.name
//output keyVaultId string = keyVault.id
//output keyVaultn string = keyVault.properties.vaultUri
