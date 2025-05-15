@description('Target resource group name')
param resourceGroupName string

@description('Project or application name')
param project string

@description('Deployment environment (dev, test, prod)')
param environment string

@description('Location for the resources')
param location string

var addressPrefixes = [
  '10.0.0.0/16'
]

var subnets = [
  {
    name: 'web'
    addressPrefix: '10.0.1.0/24'
    delegation: null
    serviceEndpoints: ['Microsoft.Storage']
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  {
    name: 'db'
    addressPrefix: '10.0.2.0/24'
    delegation: null
    serviceEndpoints: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
]

module vnet 'modules/vnet.bicep' = {
  name: 'vnet-${environment}'
  params: {
    project: project
    environment: environment
    location: location
    addressPrefixes: addressPrefixes
    subnets: subnets
    resourceGroupName: resourceGroupName
  }
}

output vnetName string = vnet.outputs.vnetName
