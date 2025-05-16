targetScope = 'resourceGroup'

@description('Project or application identifier')
param project string

@description('Environment name (e.g., dev, prod)')
param environment string

@description('Location of the VNet')
param location string

@description('Address space for the VNet')
param addressPrefixes array

@description('Array of subnet configurations')
param subnets array

@description('A set of key-value pairs to apply as tags to the resource group. Tags can be used for categorization, billing, and resource management.')
param tags object = {}

var vnetName = 'vnet-${project}-${environment}'

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      for subnet in subnets: {
        name: subnet.name
        properties: union(
          {
            addressPrefix: subnet.addressPrefix
          },
          // empty(subnet.delegation) ? {} : {
          //   delegation: subnet.delegation
          // },
          empty(subnet.serviceEndpoints) ? {} : {
            serviceEndpoints: subnet.serviceEndpoints
          },
          empty(subnet.privateEndpointNetworkPolicies) ? {} : {
            privateEndpointNetworkPolicies: subnet.privateEndpointNetworkPolicies
          },
          empty(subnet.privateLinkServiceNetworkPolicies) ? {} : {
            privateLinkServiceNetworkPolicies: subnet.privateLinkServiceNetworkPolicies
          }
        )
      }
    ]
  }
}

output vnetName string = vnet.name
