@description('Name of the Log Analytics Workspace')
param workspaceName string

@description('Location of the Log Analytics Workspace')
param location string

@description('Tags to apply')
param tags object = {}

@description('Retention in days (default 30)')
param retentionInDays int = 30

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  tags: tags
  properties: {
    retentionInDays: retentionInDays
    sku: {
      name: 'PerGB2018'  // Common SKU
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

output workspaceId string = logAnalyticsWorkspace.id
output workspaceCustomerId string = logAnalyticsWorkspace.properties.customerId
