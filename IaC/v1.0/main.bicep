
//v1.0 app

targetScope = 'resourceGroup'

@description('select an environment type for deployment')
@allowed([
  'dev'
  'prod'
])
param environmentType string = 'dev'
//param projectName string = 'cloud12'

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

param vnetAdminName string = 'vnetAdmin'
param vnetWebName string = 'vnetWeb'
param availabilityZoneAdmin string = '2'
param availabilityZoneWeb string = '1'

param storageAccountName string = '${environmentType}stg${uniqueString(resourceGroup().id)}'
param recoveryVaultName string = '${environmentType}-recoveryvault-${uniqueString(resourceGroup().id)}'
param keyVaultName string = '${environmentType}-kvault-${uniqueString(resourceGroup().id)}'

param secretName string
@secure()
param secretValue string

@secure()
param adminUsername string
@secure()
param adminPassword string 
@secure()
param webUsername string
@secure()
param webPassword string

resource pKeyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: 'myKeyvaultun200303'
}

@description('create the Admin server')
module serverAdmin 'modules/serverAdmin.bicep' =  {
  name: 'serverAdmin'
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
    availabilityZone: availabilityZoneAdmin
  }
}

@description('create the Web server')
module serverWeb 'modules/serverWeb.bicep' = {
  name: 'serverWeb'
  params: {
    webUsername: webUsername
    webPassword: webPassword
    location: location
    availabilityZone: availabilityZoneWeb
    AdminServerIP: serverAdmin.outputs.AdminPubIP
  }
}

@description('connect the two vnets through peering')
module networkPeering 'modules/networkPeering.bicep' = {
  name: 'networkPeering'
  params:{
    vnetAdminName: vnetAdminName
    vnetWebName: vnetWebName
  }
}

@description('create the storage account and container')
module storageAccount 'modules/storageAccount.bicep' = {
  name: 'storageAccount'
  params:{
    storageAccountName: storageAccountName
    environmentType: environmentType
    location: location
  }
}

@description('create the recovery vault')
module recoveryVault 'modules/recoveryVault.bicep' = {
  name: 'recoveryVault'
  params:{
    recoveryServiceVaultName: recoveryVaultName
    location: location

  }
}

//@description('create the key vault')
//module keyVault 'modules/keyVault.bicep' = {
 // name: 'keyVault'
 // params:{
  //  keyVaultName: keyVaultName
 //   location: location
 //   secretName: secretName
 //   secretValue: secretValue
 // }
//}


output environmentType string = environmentType
output PublicIpad string = serverAdmin.outputs.AdminPu
