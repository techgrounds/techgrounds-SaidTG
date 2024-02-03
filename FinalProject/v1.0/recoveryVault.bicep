
param location string = 'uksouth'
param recoveryServiceVaultName string = 'recoveryServiceVault'

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: recoveryServiceVaultName
  location: location
  identity:{
    type: 'UserAssigned'
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'   
  }
}

