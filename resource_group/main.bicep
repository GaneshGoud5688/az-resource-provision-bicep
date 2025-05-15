param resourceGroupName string
param project string
param environment string
param location string
param tags object = {}

module rgModule 'modules/resourceGroup.bicep' = {
  name: 'create-rg'
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

output createdResourceGroupName string = rgModule.outputs.resourceGroupName
output createdResourceGroupId string = rgModule.outputs.resourceGroupId
