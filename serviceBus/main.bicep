targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param namespaceName string = toLower('${project}-${environment}-sb')
param queueName string = 'myqueue'

param skuName string = 'Standard'
param maxSizeInMegabytes int = 1024
param enablePartitioning bool = false

module namespaceModule 'modules/serviceBusNamespaceModule.bicep' = {
  name: 'serviceBusNamespaceDeployment'
  params: {
    namespaceName: namespaceName
    location: location
    skuName: skuName
    tags: tags
  }
}

module queueModule 'modules/serviceBusQueueModule.bicep' = {
  name: 'serviceBusQueueDeployment'
  params: {
    namespaceName: namespaceName
    queueName: queueName
    maxSizeInMegabytes: maxSizeInMegabytes
    enablePartitioning: enablePartitioning
  }
  dependsOn: [
    namespaceModule
  ]
}

output serviceBusNamespaceId string = namespaceModule.outputs.serviceBusNamespaceId
output serviceBusQueueId string = queueModule.outputs.serviceBusQueueId
