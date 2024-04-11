
//recovery vault

param location string 

//@description('select an environment type for deployment')
//@allowed([
 // 'dev'
 // 'prod'
//])
//param environmentType string = 'dev'


param recoveryServiceVaultName string = 'recoveryvault-${uniqueString(resourceGroup().id)}'

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: recoveryServiceVaultName
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

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-04-01' = {
  parent: recoveryServiceVault
  name: 'backuppolicylinux'
  location: location
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 3
    schedulePolicy: {
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: ['2024-02-22T00:00:00Z']
      schedulePolicyType: 'SimpleSchedulePolicy'
    }
    retentionPolicy: {
      dailySchedule: {
        retentionTimes: [
          '2024-02-22T00:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
    timeZone: 'W. Europe Standard Time'
  }
}
