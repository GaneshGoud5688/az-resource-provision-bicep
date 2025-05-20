using '../main.bicep'


param project = 'finance'
param environment = 'dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'ABC Team'
}

param queueName = 'orders-queue'
param skuName = 'Standard'
param maxSizeInMegabytes = 1024
param enablePartitioning = true
