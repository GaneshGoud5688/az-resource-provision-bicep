targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param appInsightsName string = toLower('${project}-${environment}-ai')

module appInsightsModule 'modules/applicationInsightsModule.bicep' = {
  name: 'appInsightsDeployment'
  params: {
    appInsightsName: appInsightsName
    location: location
    tags: tags
    applicationType: 'web'
  }
}

output instrumentationKey string = appInsightsModule.outputs.appInsightsInstrumentationKey
output connectionString string = appInsightsModule.outputs.appInsightsConnectionString
