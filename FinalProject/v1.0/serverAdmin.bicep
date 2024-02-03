
param location string = resourceGroup().location

param vnetAdminName string = 'vnetAdmin'
param vnetAddressPrefix string = '10.10.10.0/24'
param subnetAdminName string = 'subnetAdmin'
param subnetAdressPrefix string = '10.10.10.0/25'

param nsgAdminName string = 'nsgAdmin'

param nicAdminName string = 'nicAdmin'

param vmAdminName string = 'vmAdmin'

param AdminIP string = '87.209.154.9'

param nicPrivateIP string = '10.10.10.10'

@secure()
@description('...')
param adminUsername string 

// The supplied password must be between 8-123 characters long and must satisfy at least 3 of password complexity requirements from the following:
// 1) Contains an uppercase character, 2) Contains a lowercase character, 3) Contains a numeric digit, 4) Contains a special character, 5) Control characters are not allowed 
@secure()
@description('...')
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
        name: 'nsgAdminRules'
        properties: {
          description: 'description'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: AdminIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource AdminPublicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'name'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: 'dnsname'
    }
  }
}


resource nic4admin 'Microsoft.Network/networkInterfaces@2023-06-01' = {
    name: nicAdminName
    location: location
    properties: {
        ipConfigurations: [{
            name: 'ipconfig1'
            properties: {
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
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      computerName: vmAdminName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-g2'
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

