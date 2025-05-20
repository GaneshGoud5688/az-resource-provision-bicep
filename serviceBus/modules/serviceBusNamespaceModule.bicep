@description('Name of the Service Bus Namespace')
param namespaceName string

@description('Location of the Service Bus Namespace')
param location string

@description('SKU of the Service Bus Namespace')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param skuName string = 'Standard'

@description('Tags to apply')
param tags object = {}

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: namespaceName
  location: location
  tags: tags
  sku: {
    name: skuName
    tier: skuName
  }
  properties: {
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
  }
}

output serviceBusNamespaceId string = serviceBusNamespace.id
