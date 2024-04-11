
//networking peering

param vnetWebName string 
param vnetAdminName string 

resource vnet4admin 'Microsoft.Network/virtualNetworks@2023-06-01' existing = {
  name: vnetAdminName
}

resource Admin2Web 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${vnetAdminName}-to-${vnetWebName}'
  parent: vnet4admin
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: true
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: vnet4web.id
    }
  }
}

resource vnet4web 'Microsoft.Network/virtualNetworks@2023-06-01' existing = {
  name: vnetWebName
}

resource Web2Admin 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${vnetWebName}-to-${vnetAdminName}'
  parent: vnet4web
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    doNotVerifyRemoteGateways: true
    remoteVirtualNetwork: {
      id: vnet4admin.id
    }
  }
}

output resGUID string = Admin2Web.properties.resourceGuid
