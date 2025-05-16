targetScope = 'resourceGroup'

@description('The project or application identifier, used to generate the VNet name.')
param project string

@description('The environment name (e.g., "dev", "prod"). Used to generate the VNet name.')
param environment string

@description('The Azure region where the VNet will be created. Examples: "eastus", "westeurope".')
param location string

@description('The address space for the VNet (e.g., ["10.0.0.0/16"]).')
param addressPrefixes array

@description('Array of subnet configurations.')
param subnets array

@description('Optional resource group name (can be used in tags). If not specified, the current resource group will be used.')
param resourceGroupName string = resourceGroup().name

@description('Optional tags to apply to the VNet for categorization and resource management.')
param tags object = {}

module vnetModule 'modules/vnet.bicep' = {
  name: 'create-vnet'
  params: {
    project: project
    environment: environment
    location: location
    addressPrefixes: addressPrefixes
    subnets: subnets
    tags: tags
  }
}

output createdVnetName string = vnetModule.outputs.vnetName
