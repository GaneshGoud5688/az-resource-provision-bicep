@description('Name of the Service Bus Namespace')
param namespaceName string

@description('Name of the Service Bus Queue')
param queueName string

@description('Max size of the queue in megabytes')
param maxSizeInMegabytes int = 1024

@description('Enable partitioning for the queue')
param enablePartitioning bool = false

resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = {
  name: '${namespaceName}/${queueName}'
  properties: {
    maxSizeInMegabytes: maxSizeInMegabytes
    enablePartitioning: enablePartitioning
    lockDuration: 'PT1M'
    requiresDuplicateDetection: false
    requiresSession: false
    defaultMessageTimeToLive: 'P14D'
    deadLetteringOnMessageExpiration: true
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    maxDeliveryCount: 10
  }
}
output serviceBusQueueId string = serviceBusQueue.id
