targetScope = 'resourceGroup'

@description('Project or application name')
param project string

@description('Environment name')
param environment string

@description('Azure region')
param location string

@description('Tags to apply')
param tags object = {}

param appServicePlanName string = '${project}-${environment}-funcappplan'
param functionAppName string = '${project}-${environment}-funcapp'

@description('Storage account name')
param storageAccountName string = toLower('${project}${environment}storage')

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

module functionAppPlanMod 'modules/appServicePlan.bicep' = {
  name: 'functionAppPlanDeployment'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    skuName: 'Y1'
    tags: tags
  }
}

module functionAppMod 'modules/functionApp.bicep' = {
  name: 'functionAppDeployment'
  params: {
    functionAppName: functionAppName
    location: location
    appServicePlanId: functionAppPlanMod.outputs.appServicePlanId
    storageAccountConnectionString: storageAccount.listKeys().keys[0].value
    tags: tags
  }
}

output functionAppUrl string = functionAppMod.outputs.functionAppUrl
