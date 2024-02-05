
param location string = 'uksouth'
param vmAdminName string = 'vmAdmin'

resource vm4admin 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmAdminName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_A2_v2'
    }
    osProfile: {
      computerName: 'computerName'
      adminUsername: 'adminUsername'
      adminPassword: 'adminPassword'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: 'id'
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri:  'storageUri'
      }
    }
  }
}




//SSH of RDP verbindingen met de webserver mogen alleen tot stand komen vanuit de admin server.
//Windows Server
//De admin/management server moet bereikbaar zijn met een publiek IP.
//De admin/management server moet alleen bereikbaar zijn van vertrouwde locaties (office/admin’s thuis)
//Alle VM disks moeten encrypted zijn. Gebruik industriestandaard, zo goedkoop mogelijke encryptie.  
//Hoeft weinig data op, zoals Java bestandjes. Dus OS disk van 4GB is wel genoeg, Managed Disk wss niet nodig.
