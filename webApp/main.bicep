targetScope = 'resourceGroup'

@description('The project or application identifier, used to generate resource names.')
param project string

@description('The environment name (e.g., "dev", "prod"). Used to generate resource names.')
param environment string

@description('Azure region for all resources.')
param location string

@description('Optional tags to apply to all resources.')
param tags object = {}

param appServicePlanName string = '${project}-${environment}-appserviceplan'
param webAppName string = '${project}-${environment}-webapp'
param skuName string = 'F1'
param runtimeStack string = 'PYTHON|3.9'

// Deploy App Service Plan module
module appServicePlanMod 'modules/appServicePlan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    skuName: skuName
    isLinux: contains(runtimeStack, 'PYTHON') || contains(runtimeStack, 'NODE')
    tags: tags
  }
}

// Deploy Web App module
module webAppMod 'modules/webApp.bicep' = {
  name: 'webAppDeployment'
  params: {
    webAppName: webAppName
    location: location
    appServicePlanId: appServicePlanMod.outputs.appServicePlanId
    runtimeStack: runtimeStack
    tags: tags
  }
}

output webAppUrl string = webAppMod.outputs.webAppUrl
