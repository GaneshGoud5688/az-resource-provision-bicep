@description('Name of the Container Apps Environment')
param environmentName string

@description('Location of the environment')
param location string

@description('Tags to apply to the environment')
param tags object = {}

resource containerAppEnv 'Microsoft.App/managedEnvironments@2023-02-01' = {
  name: environmentName
  location: location
  tags: tags
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: 'your-log-analytics-workspace-id'  // Replace or parameterize this if needed
        sharedKey: 'your-log-analytics-shared-key'      // Replace or parameterize this if needed
      }
    }
  }
}

output environmentId string = containerAppEnv.id
