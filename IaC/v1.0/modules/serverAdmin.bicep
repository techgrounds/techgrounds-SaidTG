
//admin server

param location string 

//@description('select an environment type for deployment')
//@allowed([
 // 'dev'
 // 'prod'
//])
//param environmentType string = 'dev'

//var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_ZRS' : 'Standard_LRS'

param vnetAdminName string = 'vnetAdmin'
param vnetAddressPrefix string = '10.10.10.0/24'
param subnetAdminName string = 'subnetAdmin'
param subnetAdressPrefix string = '10.10.10.0/25'

param nsgAdminName string = 'nsgAdmin'

param AdminServerPublicIP string = 'AdminPubIPserver'

param nicAdminName string = 'nicAdmin'

//param availabilityZone string 

param windowsOSVersion string = '2022-datacenter-g2'
param windowsVMsize string = 'Standard_B2ms'

@description('name of the virtual machine')
@minLength(1)
@maxLength(15)
param vmAdminName string = 'vmAdmin' // Windows VMs can't include period or end with hyphen. Can't use spaces, control characters, or these characters: 
// ~ ! @ # $ % ^ & * ( ) = + _ [ ] { } \ | ; : . ' " , < > / ?

param AdminHomeIP string = '87.209.154.9'

param nicPrivateIP string = '10.10.10.10'

@secure()
@description('select a username in terminal during deployment')
param adminUsername string 

// The supplied password must be between 8-123 characters long and must satisfy at least 3 of password complexity requirements from the following:
// 1) Contains an uppercase character, 2) Contains a lowercase character, 3) Contains a numeric digit, 4) Contains a special character, 5) Control characters are not allowed 
@secure()
@description('select a password in terminal during deployment')
param adminPassword string

resource vnet4admin 'Microsoft.Network/virtualNetworks@2023-06-01' = {
    name: vnetAdminName
    location: location
    properties: {
        addressSpace: {
            addressPrefixes:[
                vnetAddressPrefix
            ]
        }
    }
}

resource subnet4admin 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
    parent: vnet4admin
    name: subnetAdminName
    properties: {
        addressPrefix: subnetAdressPrefix
        networkSecurityGroup:{
            id: nsg4admin.id
        }
    }
}

//alleen bereikbaar vanaf mijn thuis IP met RDP of SSH.
resource nsg4admin 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgAdminName
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowAdminRDP'
        properties: {
          description: '*'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: AdminHomeIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 150
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowAdminSSH'
        properties: {
          description: '*'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: AdminHomeIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 200
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource AdminPublicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: AdminServerPublicIP
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}


resource nic4admin 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: nicAdminName
  location: location
  properties: {
    ipConfigurations: [{
        name: 'ipAdminConfig'
        properties: {
          publicIPAddress: {
           id: AdminPublicIPAddress.id
          }
          privateIPAllocationMethod: 'Static'
          privateIPAddress: nicPrivateIP
          subnet: {
                  id: subnet4admin.id
          } 
        }
    }]
  }
}

resource windowsVM 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmAdminName
  location: location
  //zones: [
    //availabilityZone
  //]
  properties: {
    hardwareProfile: {
      vmSize: windowsVMsize

    }
    osProfile: {
      computerName: vmAdminName
      adminUsername: adminUsername
      adminPassword: adminPassword
      //secrets:
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: windowsOSVersion
        version: 'latest'

      }
      osDisk: {
        name: 'osWindowsDisk'
        osType:'Windows'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic4admin.id
          properties:{
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

output AdminPubIP string = AdminPublicIPAddress.properties.ipAddress
