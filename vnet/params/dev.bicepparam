using '../main.bicep'

param project = 'finance'
param environment = 'dev'
param location = 'eastus'

param addressPrefixes = [
  '10.0.0.0/16'
]

param subnets = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/24'
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  },  {
    name: 'subnet2'
    addressPrefix: '10.0.2.0/24'
    serviceEndpoints: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
  }
]


param tags = {
  environment: 'dev'
  owner: 'ABC'
}
