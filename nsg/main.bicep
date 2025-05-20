targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param nsgName string = toLower('${project}-${environment}-nsg')

param securityRules array = [
  {
    name: 'Allow-HTTP'
    priority: 100
    direction: 'Inbound'
    access: 'Allow'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    description: 'Allow inbound HTTP traffic'
  }
  {
    name: 'Allow-SSH'
    priority: 110
    direction: 'Inbound'
    access: 'Allow'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    description: 'Allow inbound SSH traffic'
  }
  {
    name: 'Deny-All-Outbound'
    priority: 4000
    direction: 'Outbound'
    access: 'Deny'
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    description: 'Deny all outbound traffic'
  }
]

module nsgModule 'modules/networkSecurityGroupModule.bicep' = {
  name: 'nsgDeployment'
  params: {
    nsgName: nsgName
    location: location
    tags: tags
    securityRules: securityRules
  }
}

output nsgId string = nsgModule.outputs.nsgId
