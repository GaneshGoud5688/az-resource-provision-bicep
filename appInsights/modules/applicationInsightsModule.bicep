@description('Name of the Application Insights resource')
param appInsightsName string

@description('Location of the Application Insights resource')
param location string

@description('Tags to apply')
param tags object = {}

@description('Application Insights kind')
param kind string = 'web'

@description('Application Type')
@allowed([
  'web'
  'other'
  'java'
  'node.js'
  'ios'
  'android'
  'other'
])
param applicationType string = 'web'

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  tags: tags
  kind: kind
  properties: {
    Application_Type: applicationType
  }
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output appInsightsConnectionString string = appInsights.properties.ConnectionString
