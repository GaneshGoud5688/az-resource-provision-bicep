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

@description('Target resource group name (optional, used in tags)')
param resourceGroupName string = resourceGroup().name

// Compose VNet name from project + environment
var vnetName = '${project}-vnet-${environment}'

// Default tags to apply on the VNet
var defaultTags = {
  environment: environment
  project: project
  resourceGroup: resourceGroupName
  deployedBy: 'bicep'
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: defaultTags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        delegation: subnet.delegation
        serviceEndpoints: subnet.serviceEndpoints
        privateEndpointNetworkPolicies: subnet.privateEndpointNetworkPolicies
        privateLinkServiceNetworkPolicies: subnet.privateLinkServiceNetworkPolicies
      }
    }]
  }
}

output vnetName string = vnet.name
