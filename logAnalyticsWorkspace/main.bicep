targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param workspaceName string = toLower('${project}-${environment}-law')

param retentionInDays int = 30

module law 'modules/logAnalyticsWorkspaceModule.bicep' = {
  name: 'lawDeployment'
  params: {
    workspaceName: workspaceName
    location: location
    tags: tags
    retentionInDays: retentionInDays
  }
}

output workspaceId string = law.outputs.workspaceId
output workspaceCustomerId string = law.outputs.workspaceCustomerId
