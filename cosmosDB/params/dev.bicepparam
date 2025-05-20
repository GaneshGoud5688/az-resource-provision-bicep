using '../main.bicep'


param project = 'finance'
param environment = 'dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'ABC Team'
}

param databaseName = 'finance-db'
param containerName = 'finance-container'
param partitionKeyPath = '/customerId'
param databaseThroughput = 400
