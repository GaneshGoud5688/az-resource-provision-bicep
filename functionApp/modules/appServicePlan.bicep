@description('Name of the App Service plan for the Function App')
param appServicePlanName string

@description('Location for the App Service plan')
param location string

@description('SKU for the App Service plan')
param skuName string = 'Y1' // Y1 is the consumption plan SKU for Functions

@description('Tags to apply to the App Service Plan')
param tags object = {}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: skuName
    tier: 'Dynamic' // Consumption plan for Function Apps
  }
  properties: {
    reserved: true // Linux hosting
  }
}

output appServicePlanId string = appServicePlan.id
