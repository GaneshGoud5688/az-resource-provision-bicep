targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param storageAccountName string = toLower('${project}${environment}storage')

module storage 'modules/storageAccountModule.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
    tags: tags
  }
}

output storageAccountId string = storage.outputs.storageAccountId
