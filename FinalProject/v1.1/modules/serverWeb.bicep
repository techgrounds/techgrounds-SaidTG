
// Public IP > Application Gateway > VMSS > Autoscale 

param location string 

param publicIPaGname string = 'publicIPappGateway'

param appGatewayName string = 'applicationGatewayWeb'
param backendPoolAGwebName string  = '${VMScaleSetName}backendPoolAG'

param VMScaleSetName string
param availabilityZone string = '1'

@description('The VM size')
param skuName string = 'Standard_B2ms'

@description('Specifies the username of the administrator account.')
@minLength(1)
@maxLength(64)
@secure()
param linuxAdminUsername string 

@description('Specifies the password of the administrator account.')
@minLength(6)
@maxLength(72)
@secure()
param linuxAdminPassword string 

param AdminServerIP string 

param vnetWebName string = 'vnetWeb'
param vnetWebAddressPrefix string = '10.20.20.0/24'

param subnetVMSSname string = 'subnetVMSS'
param subnetVMSSaddressPrefix string = '10.20.20.0/25'

param subnetAGname string = 'subnetAG'
param subnetAGaddressPrefix string = '10.20.20.128/25'

param nsgVMSSname string = 'nsgVMSS'
param nsgAGname string = 'nsgAG'

// Public IP Address for Application Gateway //

resource PublicIP4AG 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: publicIPaGname
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

//vnet
//nsg ag
//nsg vmss
//subnet4ag
//subnet4vmss

// Application Gateway //

resource appGateway 'Microsoft.Network/applicationGateways@2023-09-01' = {
  name: appGatewayName
  dependsOn: [
    vnet4web
    subnet4ag
  ]
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 1
    }
    gatewayIPConfigurations: [
      {
        name: 'name'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetWebName, subnetAGname)
          }
        }
      }
    ]
    sslCertificates: [
      { 
        name: 'WebServerCertificate'
        properties: {
          data: loadFileAsBase64('../certificate/certificate.pfx')
          password: '12345'
        }
      }
    ]
    sslPolicy: {
      policyType: 'Custom'
      minProtocolVersion: 'TLSv1_2'
      cipherSuites: [
        'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384'
        'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256'
        'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384'
        'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
      ]
    }
    frontendIPConfigurations: [
      {
        name: 'AGfrontEndPublicIP'
        properties: {
          publicIPAddress: {
            id: PublicIP4AG.id
          }
        }
      }
    ]
    frontendPorts: [
       {
        name: 'AGfrontEndPortHTTP'
        properties: {
          port: 80
        }
       }
      {
        name: 'AGfrontEndPortHTTPS'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: backendPoolAGwebName
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'AGbackEndPortHTTP'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 30
        }
      }
      {
        name: 'AGbackEndPortHTTPS'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 30
        }
      }
    ]
    httpListeners: [
      {
        name: 'http-listener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'AGfrontEndPublicIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'AGfrontEndPortHTTP')
          }
          protocol: 'Http'
        }
      }
      {
        name: 'https-listener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'AGfrontEndPublicIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'AGfrontEndPortHTTPS')
          }
          protocol: 'Https'
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', appGatewayName, 'WebServerCertificate')
          }
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'ruleHTTPS'
        properties: {
          ruleType: 'Basic'
          priority: 100
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'https-listener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, backendPoolAGwebName)
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGatewayName, 'AGbackEndPortHTTP')
          }
        }
      }
      {
        name: 'ruleHTTP'
        properties: {
          ruleType: 'Basic'
          priority: 110
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'http-listener')
          }
          redirectConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', appGatewayName, 'redirect-http-To-https')
          }
        }
      }
    ]
    redirectConfigurations: [
      {
        name: 'redirect-http-To-https'
        properties: {
          redirectType: 'Permanent'
          includePath: true
          includeQueryString: true      
          targetListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'https-listener')
          }
        }
      }
    ]
    probes: [
      {
        name: 'healthProbeAG'
        properties:{
          host: VMScaleSetName
          interval: 15
          path: '/'
          port: 443
          protocol: 'Https'
          timeout: 10
          unhealthyThreshold: 10
          match:{
            statusCodes: [
              '200'
            ]
          }
        }
      }
    ]
  }
}

// Virtual Machine Scale Set //

resource vmss4web 'Microsoft.Compute/virtualMachineScaleSets@2023-09-01' = {
  name: VMScaleSetName
  location: location
  zones: [
    availabilityZone
  ]
  dependsOn: [
    appGateway
    vnet4web
    subnet4vmss
  ]
  sku: {
    capacity: 3
    name: skuName
    tier: 'Standard'
  }
  properties: {
    automaticRepairsPolicy: {
      enabled: true 
    }

    overprovision: true
    singlePlacementGroup: false
    upgradePolicy: {
      mode: 'Automatic'
    }
    virtualMachineProfile: {
      extensionProfile: {
        extensions: [
          {
            name: 'healhExtension'
            properties: {
              autoUpgradeMinorVersion:true
              publisher:'Microsoft.ManagedServices'
              type:'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                protocol: 'http'
                port: 80
              } 
            }
          } 
        ]
      }
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          osType: 'Linux'
        }
        imageReference: {
          offer:'0001-com-ubuntu-server-jammy'
          publisher: 'Canonical'
          sku:'22_04-lts-gen2'
          version:'latest'
      }
    }
      osProfile: {
        computerNamePrefix: VMScaleSetName
        adminUsername: linuxAdminUsername
        adminPassword: linuxAdminPassword
        customData: loadFileAsBase64('../script/installWeb.sh')
        linuxConfiguration: {
          disablePasswordAuthentication: true
          ssh: {
            publicKeys: [
              {
                path: '/home/${linuxAdminUsername}/.ssh/authorized_keys'
                keyData: loadTextContent('../sshKeys/ssh_key.pub')
              }
            ]
          }
        }
      } 
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'vmssNic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'ipconfig'
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets/', vnetWebName, subnetVMSSname) 
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                      id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGatewayName, backendPoolAGwebName)
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}

// Auto Scaling for Virtual Machine Scale Set //

resource autoScaling 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: 'autoscalevmss'
  location: location
  properties: {
    targetResourceUri: vmss4web.id
    enabled: true
    profiles: [
      {
        name: 'scalingvmss'
        capacity: {
          default: '1'
          maximum: '3'
          minimum: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss4web.id
              operator: 'GreaterThan'
              statistic: 'Average'
              threshold: 75
              timeAggregation: 'Average'
              timeGrain: 'PT1M'
              timeWindow: 'PT3M'
            }
            scaleAction: {
              cooldown: 'PT3M'
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss4web.id
              operator: 'LessThan'
              statistic: 'Average'
              threshold: 25
              timeAggregation: 'Average'
              timeGrain: 'PT1M'
              timeWindow: 'PT3M'
            }
            scaleAction: {
              cooldown: 'PT3M'
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
            }
          }
        ]
      }
    ]
  }
}

// Virtual Network //

resource vnet4web 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetWebName
  location: location
  properties: {
      addressSpace: {
          addressPrefixes:[
              vnetWebAddressPrefix
          ]
      }
  }
}

resource subnet4vmss 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' = {
  parent: vnet4web
  dependsOn: [
    subnet4ag
  ]
  name: subnetVMSSname
  properties: {
      addressPrefix: subnetVMSSaddressPrefix
      networkSecurityGroup:{
          id: nsg4vmss.id
      }
  }
}

resource subnet4ag 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' = {
  parent: vnet4web
  name: subnetAGname
  properties: {
      addressPrefix: subnetAGaddressPrefix
      networkSecurityGroup:{
          id: nsg4ag.id
      }
  }
}

//alleen bereikbaar vanaf de admin server met RDP of SSH.
resource nsg4vmss 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
name: nsgVMSSname
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
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
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
        destinationAddressPrefix: '*'
        access: 'Allow'
        priority: 200
        direction: 'Inbound'
      }
    }
    {
      name: 'AllowWebHTTPS'
      properties: {
        description: '*'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '443'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Allow'
        priority: 250
        direction: 'Inbound'
      }
    }
    {
      name: 'AllowWebHTTP'
      properties: {
        description: '*'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '80'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Allow'
        priority: 300
        direction: 'Inbound'
      }
    }
  ]
}
}

resource nsg4ag 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgAGname
  location: location
  properties: {
    securityRules: [
      { name: 'http'
      properties: {
        access: 'Allow'                       
        direction: 'Inbound'
        priority: 200
        protocol: 'Tcp'
        sourcePortRange: '*'
        sourceAddressPrefix: '*'
        destinationPortRange: '80'
        destinationAddressPrefix: '*'
      }
    }
    {
    name: 'GatewayManager'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: 'GatewayManager'
          sourcePortRange: '*' 
          destinationAddressPrefix: '*' 
          destinationPortRange: '65200-65535' 
          access: 'Allow'
          priority: 1100
          direction: 'Inbound'
        }
      }
      { name: 'https'
        properties: {
          access: 'Allow' 
          direction: 'Inbound' 
          priority: 100
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
        }
      } 
    ]
  }
}

output appGatewayPubIP string = PublicIP4AG.properties.ipAddress
output vmssID string = vmss4web.id
output vmssName string = vmss4web.name
