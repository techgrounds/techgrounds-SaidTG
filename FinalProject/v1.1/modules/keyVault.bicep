
//The requirements for Key Vault names are: between 3 and 24 characters long. Alphanumerics and hyphens (dash).
//Start with a letter. End with a letter or digit. Can not contain consecutive hyphens. Key Vault names must be globally unique.


param location string 

param managedIdentityName string = 'adminIdentity'

@description('The unique name of the Key Vault. uniqueString is used to ensure that resource names are unique.')
@minLength(3)
@maxLength(24) // change characters before $ sign as you wish.
param keyVaultName string 

var tenantId = 'de60b253-74bd-4365-b598-b9e55a2b208d'
var objectId = '5e629060-8ed6-4f5d-bdf4-310d6c3bec21'

@secure()
param windowsAdminUsername string
@secure()
param windowsAdminPassword string 

@secure()
param linuxAdminUsername string
@secure()
param linuxAdminPassword string

// Create the managed identity
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
  tags: {
   keyvault: 'keyvaultIdentity'   
  }
}

// Create the keyvault and add the username and password as secrets
resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    tenantId: tenantId
    accessPolicies: [
      {
        objectId: objectId
        tenantId: tenantId
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
        }
      }
      {
        objectId: objectId
        tenantId: tenantId
        permissions: {
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          keys: [
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
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}


resource secret1 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'windowsUsername'
  properties: {
    value: windowsAdminUsername
  }
}

resource secret2 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyvault
  name: 'windowsPassword'
  properties: {
    value: windowsAdminPassword
  }
}

resource secret3 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'linuxUsername'
  properties: {
    value: linuxAdminUsername
  }
}

resource secret4 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'linuxPassword'
  properties: {
    value: linuxAdminPassword
  }
}

resource secret5 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'sshpublicKey'
  properties: {
    value: loadTextContent('../sshKeys/ssh_key.pub')
  }
}

resource secret6 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'sshprivateKey'
  properties: {
    value: loadTextContent('../sshKeys/ssh_key')
  }
}

resource secret7 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'certificateSSLpub'
  properties: {
    value: loadTextContent('../certificate/certificate.pem')
  }
}

resource secret8 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyvault
  name: 'certificateSSLprivate'
  properties: {
    value: loadTextContent('../certificate/private.key')
  }
}

output keyVaultName string = keyvault.name
output keyvaultURI string = keyvault.properties.vaultUri
output keyvaultID string = keyvault.id
output managedIdentityClientID string = managedIdentity.properties.clientId
