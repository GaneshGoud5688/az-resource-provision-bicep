@description('Name of the Cosmos DB Account')
param cosmosAccountName string

@description('Location of the Cosmos DB Account')
param location string

@description('Tags to apply to the Cosmos DB Account')
param tags object = {}

@description('Throughput for the database (RU/s)')
param databaseThroughput int = 400

@description('Name of the Cosmos DB SQL Database')
param databaseName string

@description('Name of the Cosmos DB Container')
param containerName string

@description('Partition key path for the container')
param partitionKeyPath string = '/partitionKey'

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-04-15' = {
  name: cosmosAccountName
  location: location
  tags: tags
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    capabilities: []
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
  }
}

resource cosmosSqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-04-15' = {
  name: '${cosmosDbAccount.name}/${databaseName}'
  properties: {
    resource: {
      id: databaseName
    }
    options: {
      throughput: databaseThroughput
    }
  }
  dependsOn: [
    cosmosDbAccount
  ]
}

resource cosmosSqlContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-04-15' = {
  name: '${cosmosDbAccount.name}/${databaseName}/${containerName}'
  properties: {
    resource: {
      id: containerName
      partitionKey: {
        paths: [
          partitionKeyPath
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
      }
    }
    options: {}
  }
  dependsOn: [
    cosmosSqlDatabase
  ]
}

output cosmosDbAccountEndpoint string = cosmosDbAccount.properties.documentEndpoint
output cosmosDbAccountName string = cosmosDbAccount.name
