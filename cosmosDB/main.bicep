targetScope = 'resourceGroup'

@description('Project name used for naming resources')
param project string

@description('Deployment environment (e.g., dev, test, prod)')
param environment string

@description('Azure region where resources will be deployed')
param location string

@description('Tags to apply to all resources')
param tags object = {}

@description('Name of the Azure Cosmos DB account (auto-generated from project and environment)')
param cosmosAccountName string = toLower('${project}-${environment}-cosmos')

@description('Name of the Cosmos DB database')
param databaseName string = 'mydatabase'

@description('Name of the Cosmos DB container')
param containerName string = 'mycontainer'

@description('Path to be used as the partition key in the Cosmos DB container')
param partitionKeyPath string = '/partitionKey'

@description('Provisioned throughput (RU/s) for the Cosmos DB database')
param databaseThroughput int = 400


module cosmosDb 'modules/cosmosDbModule.bicep' = {
  name: 'cosmosDbDeployment'
  params: {
    cosmosAccountName: cosmosAccountName
    location: location
    tags: tags
    databaseName: databaseName
    containerName: containerName
    partitionKeyPath: partitionKeyPath
    databaseThroughput: databaseThroughput
  }
}

output cosmosEndpoint string = cosmosDb.outputs.cosmosDbAccountEndpoint
output cosmosAccount string = cosmosDb.outputs.cosmosDbAccountName
