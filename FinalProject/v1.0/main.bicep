
//v1.0 app

targetScope = 'resourceGroup'

@description('select an environment type for deployment')
@allowed([
  'dev'
  'prod'
])
param environmentType string 

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

param vnetWebName string
param vnetAdminName string
param storageAccountName string = 'stgacc${uniqueString(resourceGroup().id)}'
param recoveryVaultName string = 'recoveryVault-v1'
param keyVaultName string = 'keyvault${uniqueString(resourceGroup().id)}'

@secure()
param adminUsername string

@secure()
param adminPassword string 

@secure()
param webUsername string

@secure()
param webPassword string

@description('create the Admin server')
module serverAdmin 'modules/serverAdmin.bicep' = {
  name: 'serverAdmin'
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
  }
}

@description('create the Web server')
module serverWeb 'modules/serverWeb.bicep' = {
  name: 'serverWeb'
  params: {
    webUsername: webUsername
    webPassword: webPassword
    location: location
  }
}

@description('connect the two vnets through peering')
module networkPeering 'modules/networkPeering.bicep' = {
  name: 'networkPeering'
  params:{
    vnetWebName: vnetWebName
    vnetAdminName: vnetAdminName
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

@description('create the key vault')
module keyVault 'modules/keyVault.bicep' = {
  name: 'keyVault'
  params:{
    keyVaultName: keyVaultName
    location: location
  }
}
