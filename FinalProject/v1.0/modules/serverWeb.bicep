
param location string = resourceGroup().location

param vnetWebName string = 'vnetWeb'
param vnetAddressPrefix string = '10.20.20.0/24'
param subnetWebName string = 'subnetWeb'
param subnetAdressPrefix string = '10.20.20.0/25'

param nsgWebName string = 'nsgWeb'

param WebServerPublicIP string = 'WebPubIPserver'

param nicWebName string = 'nicWeb'

@description('name of the virtual machine')
@minLength(1)
@maxLength(64)
param vmWebName string = 'vmWeb' // Linux VMs can't end with period or hyphen. Can't use spaces, control characters, or these characters:
// ~ ! @ # $ % ^ & * ( ) = + _ [ ] { } \ | ; : . ' " , < > / ?

param AdminServerIP string = '10.10.10.10'

param nicPrivateIP string = '10.20.20.20'

@secure()
@description('...')
param webUsername string 

// The supplied password must be between 8-123 characters long and must satisfy at least 3 of password complexity requirements from the following: 
// 1) Contains an uppercase character, 2) Contains a lowercase character, 3) Contains a numeric digit, 4) Contains a special character, 5) Control characters are not allowed 
@secure()
@description('...')
param webPassword string

resource vnet4web 'Microsoft.Network/virtualNetworks@2023-06-01' = {
    name: vnetWebName
    location: location
    properties: {
        addressSpace: {
            addressPrefixes:[
                vnetAddressPrefix
            ]
        }
    }
}

resource subnet4web 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
    parent: vnet4web
    name: subnetWebName
    properties: {
        addressPrefix: subnetAdressPrefix
        networkSecurityGroup:{
            id: nsg4web.id
        }
    }
}

//alleen bereikbaar vanaf de admin server met RDP of SSH.
resource nsg4web 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: nsgWebName
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowWebRDP'
        properties: {
          description: '*'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: AdminServerIP
          destinationAddressPrefix: nicPrivateIP
          access: 'Allow'
          priority: 150
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowWebSSH'
        properties: {
          description: '*'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: AdminServerIP
          destinationAddressPrefix: nicPrivateIP
          access: 'Allow'
          priority: 200
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource WebPublicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: WebServerPublicIP
  location: location
  sku:{
    name:'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: 'cloud12' //It must conform to the following regular expression: ^[a-z][a-z0-9-]{1,61}[a-z0-9]$."}
    }
  }
}


resource nic4web 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: nicWebName
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipWebConfig'
      properties: {
        publicIPAddress: {
          id: WebPublicIPAddress.id
        }
        privateIPAllocationMethod: 'Static'
        privateIPAddress: nicPrivateIP
        subnet: {
          id: subnet4web.id
        }
      }
    }]
  }
}

resource LinuxVM 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmWebName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: vmWebName
      adminUsername: webUsername
      adminPassword: webPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }  
      osDisk: {
        name: 'osLinuxDisk'
        osType: 'Linux'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic4web.id
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

resource vmApacheInstall 'Microsoft.Compute/virtualMachines/extensions@2023-09-01' = {
  parent: LinuxVM
  name: 'installApacheOnWebVM'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'customScriptExtension'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      skipDos2Unix: false 
      fileUris: [
        'https://raw.githubusercontent.com/techgrounds/techgrounds-SaidTG/main/FinalProject/v1.0/scripts/installWeb.sh'
      ]
    }
    protectedSettings: {
      commandToExecute: 'sh installWeb.sh'
    }
  }
}