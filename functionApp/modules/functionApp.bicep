@description('Name of the Function App')
param functionAppName string

@description('Location for the Function App')
param location string

@description('App Service Plan Resource ID')
param appServicePlanId string

@description('Storage Account connection string for Function App')
param storageAccountConnectionString string

@description('Tags to apply to the Function App')
param tags object = {}

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  tags: tags
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.9'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storageAccountConnectionString
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
      ]
    }
    httpsOnly: true
  }
}

output functionAppUrl string = 'https://${functionApp.properties.defaultHostName}/api'
