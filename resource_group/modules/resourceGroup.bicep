targetScope = 'subscription'

@description('The name of the resource group to be created.')
param resourceGroupName string

@description('The Azure region where the resource group will be created. Examples: "eastus", "westeurope".')
param location string

@description('A set of key-value pairs to apply as tags to the resource group. Tags can be used for categorization, billing, and resource management.')
param tags object = {}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

output resourceGroupName string = rg.name
output resourceGroupId string = rg.id
