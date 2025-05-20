@description('Name of the Network Security Group')
param nsgName string

@description('Location for the Network Security Group')
param location string

@description('Tags to apply')
param tags object = {}

@description('Network Security Rules')
param securityRules array = [
  // Default rule example:
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
]

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      for rule in securityRules: {
        name: rule.name
        properties: {
          priority: rule.priority
          direction: rule.direction
          access: rule.access
          protocol: rule.protocol
          sourcePortRange: rule.sourcePortRange
          destinationPortRange: rule.destinationPortRange
          sourceAddressPrefix: rule.sourceAddressPrefix
          destinationAddressPrefix: rule.destinationAddressPrefix
          description: rule.description
        }
      }
    ]
  }
}

output nsgId string = nsg.id
