targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param cosmosAccountName string = toLower('${project}-${environment}-cosmos')
param databaseName string = 'mydatabase'
param containerName string = 'mycontainer'
param partitionKeyPath string = '/partitionKey'
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
