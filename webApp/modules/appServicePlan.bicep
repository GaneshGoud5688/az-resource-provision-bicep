@description('Name of the App Service plan')
param appServicePlanName string

@description('Location for the App Service plan')
param location string

@description('SKU for the App Service plan')
param skuName string

@description('Is Linux App Service Plan')
param isLinux bool = true

@description('Tags to apply to the App Service Plan')
param tags object = {}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: skuName
    tier: (skuName == 'F1') ? 'Free' : 'Basic'
    size: skuName
    capacity: 1
  }
  properties: {
    reserved: isLinux
  }
}

output appServicePlanId string = appServicePlan.id
