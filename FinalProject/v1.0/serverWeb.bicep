
param location string = resourceGroup().location

param vnetWebName string = 'vnetWeb'
param vnetAddressPrefix string = '10.20.20.0/24'
param subnetWebName string = 'subnetWeb'
param subnetAdressPrefix string = '10.20.20.0/25'

param nsgWebName string = 'nsgWeb'

param nicWebName string = 'nicWeb'

param vmWebName string = 'vmWeb'

param AdminServer string = '10.10.10.10'

//param AdminServerIP string

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
        name: 'InboundNsgWebRules'
        properties: {
          description: 'description'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: AdminServer
          destinationAddressPrefix: AdminServer
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource WebPublicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'name'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: 'dnsname'
    }
  }
}


resource nic4web 'Microsoft.Network/networkInterfaces@2023-06-01' = {
    name: nicWebName
    location: location
    properties: {
        ipConfigurations: [{
            name: 'ipconfig1'
            properties: {
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
      vmSize: 'Standard_B1s'
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

resource vmApacheInstall 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: LinuxVM
  name: 'vmWebApache'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'customScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings:
  }
}
