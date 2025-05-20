@description('Name of the Web App')
param webAppName string

@description('Location for the Web App')
param location string

@description('App Service Plan Resource ID')
param appServicePlanId string

@description('Runtime stack (e.g., PYTHON|3.9, NODE|18-lts)')
param runtimeStack string

@description('Tags to apply to the Web App')
param tags object = {}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  tags: tags
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: runtimeStack
    }
    httpsOnly: true
  }
}

output webAppUrl string = webApp.properties.defaultHostName
