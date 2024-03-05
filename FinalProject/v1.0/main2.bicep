
param location string = 'westeurope'
//param availabilityZoneAdmin string = '1'

param secretName string = 'Said'
@secure()
param adminName string
@secure()
param adminPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: 'keyVault-djl3xkehzq7ha'
}

@description('create the Admin server')
module serverAdmin 'modules/serverAdmin.bicep' =  {
  name: 'serverAdmin'
  params: {
    adminUsername: adminName
    adminPassword: keyVault.getSecret(secretName)               //   symbolickeyvaultname.getSecret('nameOFsecretINkeyvault')
    location: location
    //availabilityZone: availabilityZoneAdmin
  }
}

//var ipRulesKv = serverAdmin.outputs.AdminPubIP
//output servAdminIp string = serverAdmin.outputs.AdminPubIP
//output ipRuleskv string = keyVault134.outputs.keyVault12
