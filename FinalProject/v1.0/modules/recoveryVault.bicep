
//recovery vault

param location string = resourceGroup().location

//@description('select an environment type for deployment')
//@allowed([
 // 'dev'
 // 'prod'
//])
//param environmentType string = 'dev'

param vmWebName string = 'vmWeb'

resource LinuxVM 'Microsoft.Compute/virtualMachines@2020-12-01' existing = {
  name: vmWebName
}

param recoveryServiceVaultName string 
param backupVM string = 'backupWebVM'

param TimeToStartBackUp string = '23:00'

//var backupPolicies = 'backupPolicyName'

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: recoveryServiceVaultName
  dependsOn: [
    LinuxVM
  ]
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
    properties:{
      publicNetworkAccess:'Enabled'
      restoreSettings:{
        crossSubscriptionRestoreSettings:{
          crossSubscriptionRestoreState: 'Enabled'
        }
      }
      securitySettings:{
        immutabilitySettings:{
          state:'Disabled'
        }
        softDeleteSettings:{
          softDeleteState:'Enabled'
          softDeleteRetentionPeriodInDays: 7
        }
      }
    }
  }

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = {
  name: backupVM
  location: location
  parent: recoveryServiceVault
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 5
    policyType: 'V2'
    retentionPolicy: {
      retentionPolicyType: 'SimpleRetentionPolicy'
      retentionDuration: {
        count: 7
         durationType: 'Days'
      }
    }
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency:'Daily'
      dailySchedule: {
        scheduleRunTimes: [
          '1'
        ]
      }
      hourlySchedule: {
        scheduleWindowStartTime: '23:00'
      }
    }
    protectedItemsCount: 1
  }
}

resource protectionContainer 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers@2023-08-01' = {
  name: 
}

resource  protectedItem 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-08-01' = {
  name: 
}
