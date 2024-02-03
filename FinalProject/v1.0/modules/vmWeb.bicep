
param location string = 'uksouth'
param vmWebName string = 'vmWeb'

resource vm4web 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmWebName
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
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '22_04-lts'
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
        storageUri: 'storageUri'
      }
    }
  }
}








//SSH of RDP verbindingen met de webserver mogen alleen tot stand komen vanuit de admin server.
//Linux Server
//De webserver moet dagelijks gebackupt worden. De backups moeten 7 dagen behouden worden.
//De webserver moet op een geautomatiseerde manier geïnstalleerd worden.
//Alle VM disks moeten encrypted zijn. Gebruik industriestandaard, zo goedkoop mogelijke encryptie.  
//Hoeft weinig data op, zoals Java bestandjes. Dus OS disk van 4GB is wel genoeg, Managed Disk wss niet nodig.
