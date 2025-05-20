targetScope = 'resourceGroup'

@description('Project or application name')
param project string

@description('Environment name')
param environment string

@description('Location')
param location string

@description('Tags to apply')
param tags object = {}

var environmentName = '${project}-${environment}-containerapp-env'
var containerAppName = '${project}-${environment}-containerapp'
var containerImage = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
var containerPort = 80
var cpu = 1
var memory = 1

// You should create or provide your Log Analytics workspace details here, or create as a resource separately.
@description('Log Analytics Workspace Customer ID')
param logAnalyticsCustomerId string

@description('Log Analytics Workspace Shared Key')
@secure()
param logAnalyticsSharedKey string

module containerAppEnv 'modules/containerAppEnvironmentModule.bicep' = {
  name: 'containerAppEnvDeployment'
  params: {
    environmentName: environmentName
    location: location
    tags: tags
  }
}

module containerApp 'modules/containerAppModule.bicep' = {
  name: 'containerAppDeployment'
  params: {
    containerAppName: containerAppName
    location: location
    environmentId: containerAppEnv.outputs.environmentId
    containerImage: containerImage
    containerPort: containerPort
    cpu: cpu
    memory: memory
    tags: tags
  }
}

output containerAppUrl string = containerApp.outputs.containerAppUrl
