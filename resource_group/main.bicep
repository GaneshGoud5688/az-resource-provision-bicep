targetScope = 'subscription'

// @description: This Bicep template creates a resource group with a dynamic name based on the provided project and environment parameters.
// The resource group will be created in the specified location and can be tagged with key-value pairs.
// Outputs the resource group's name and ID.

@description('The name of the project (e.g., "finance", "app"). Used to generate the resource group name.')
param project string

@description('The environment where the resources will be deployed (e.g., "dev", "test", "prod"). Used to generate the resource group name.')
param environment string

@description('The Azure region where the resource group and resources will be created. Examples: "eastus", "westeurope".')
param location string

@description('A set of key-value pairs to apply as tags to the resource group. Tags are useful for categorization and resource management.')
param tags object = {}

// Create resource group name using project and environment
var dynamicResourceGroupName = 'rg-${project}-${environment}'

// Call the module to create the resource group
module rgModule 'modules/resourceGroup.bicep' = {
  name: 'create-rg'
  params: {
    resourceGroupName: dynamicResourceGroupName
    location: location
    tags: tags
  }
}

output createdResourceGroupName string = rgModule.outputs.resourceGroupName
output createdResourceGroupId string = rgModule.outputs.resourceGroupId
