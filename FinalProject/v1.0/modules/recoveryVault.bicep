
param location string = 'uksouth'
param recoveryServiceVaultName string = 'recoveryServiceVault'

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2021-01-01' = {
  name: recoveryServiceVaultName
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  identity:{
    type: 'None'
  }
  properties:{
    encryption:{
      keyVaultProperties:{
        keyUri: 
      }
    }
  }
}

