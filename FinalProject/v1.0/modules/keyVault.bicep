//When naming Azure resources, resource names must meet service requirements. The requirements for Key Vault names are:
//Between 3 and 24 characters long.
//Alphanumerics and hyphens (dash).
//Start with a letter.
//End with a letter or digit.
//Can not contain consecutive hyphens.
//Key Vault names must be globally unique.

param location string = resourceGroup().location

@description('The unique name of the Key Vault. uniqueString is used to ensure that resource names are unique.')
@minLength(3) // alphanumerics and hyphens. Start with letter. End with letter or digit. Can't contain consecutive hyphens.
@maxLength(24) // change characters before $ sign as you wish.
param keyVaultName string = 'keyVaultv1-${uniqueString(resourceGroup().id)}' 

var tenantId = 'de60b253-74bd-4365-b598-b9e55a2b208d'
var objectId = '5e629060-8ed6-4f5d-bdf4-310d6c3bec21'

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
      defaultAction:'Allow'
      bypass:'AzureServices'
    }
  }
}

output keyVaultName string = keyVaultName