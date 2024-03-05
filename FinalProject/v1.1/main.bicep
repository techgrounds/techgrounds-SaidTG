
//v1.1 

param location string = 'uksouth'

@description('select an environment type for deployment')
@allowed([ 
  'dev' 
  'prod' 
])
param environmentType string = 'dev'

@description('The unique name of the Key Vault. uniqueString is used to ensure that resource names are unique.')
@minLength(3)
@maxLength(24) // change characters before $ sign as you wish.
param keyVaultName string = '${environmentType}-kvault${uniqueString(resourceGroup().id)}'
param storageAccountName string = '${environmentType}storage${uniqueString(resourceGroup().id)}'
param recoveryVaultName string = '${environmentType}-recoveryvault-${uniqueString(resourceGroup().id)}'
param VMScaleSetName string = 'VMSSWebServer'

@description('login details for Windows Admin Server')
@secure()
param wAdminUsername string 
@secure()
param wAdminPassword string

@description('login details for Linux/Ubuntu Server with VMSS')
@secure()
param lAdminUsername string
@secure()
param lAdminPassword string

param vnetAdminName string = 'vnetAdmin'
//param vnetAdminAddressPrefix string = '10.10.10.0/24'

//param subnetAdminName string = 'subnetAdmin'
//param subnetAdminAdressPrefix string = '10.10.10.0/25'

param vnetWebName string = 'vnetWeb'
//param vnetWebAddressPrefix string = '10.20.20.0/24'

//param subnetVMSSname string = 'subnetWeb'
//param subnetVMSSaddressPrefix string = '10.20.20.0/25'

//param subnetAGname string = 'subnetAG'
//param subnetAGaddressPrefix string = '10.20.20.0/25'

//param nsgVMSSname string = 'nsgVMSS'
//param nsgAGname string = 'nsgAG'

// 1. Key Vault //
module keyVault 'modules/keyVault.bicep' = {
  name: keyVaultName
  params: {
    keyVaultName: keyVaultName
    location: location
    windowsAdminUsername: wAdminUsername
    windowsAdminPassword: wAdminPassword
    linuxAdminUsername: lAdminUsername
    linuxAdminPassword: lAdminPassword

  }
}

// 2. Admin Server //
module serverAdmin 'modules/serverAdmin.bicep' = {
  name: 'adminServer'
  params: {
    location: location
    adminUsername: wAdminUsername
    adminPassword: wAdminPassword
  }
}

// 3. Web Server //
module serverWeb 'modules/serverWeb.bicep' = {
  name: 'webServer'
  params: {
    VMScaleSetName: VMScaleSetName
    location: location
    linuxAdminPassword: lAdminPassword
    linuxAdminUsername: lAdminUsername
    AdminServerIP: serverAdmin.outputs.AdminPubIP
  }
}

// 4. Networking Peering //
module networkPeering 'modules/networkPeering.bicep' = {
  name: 'networkPeering'
  dependsOn: [
    serverAdmin
    serverWeb
  ]
  params: {
    vnetAdminName: vnetAdminName
    vnetWebName: vnetWebName
  }
}

// 5. Storage Account //
module storage 'modules/storage.bicep' = {
  name: storageAccountName
  params: {
    storageName: storageAccountName
    location: location
  }
}

// 6. Recovery Vault //
module recoveryVault 'modules/recoveryVault.bicep' = {
  name: recoveryVaultName
  params: {
    location: location
    recoveryServiceVaultName: recoveryVaultName
  }
}
