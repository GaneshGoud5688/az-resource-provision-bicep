targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param principalObjectId string
param tenantId string

param keyVaultName string = toLower('${project}-${environment}-kv')

module keyVaultModule 'modules/keyVaultModule.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    keyVaultName: keyVaultName
    location: location
    principalObjectId: principalObjectId
    tenantId: tenantId
    tags: tags
  }
}

output keyVaultUri string = keyVaultModule.outputs.keyVaultUri
output keyVaultId string = keyVaultModule.outputs.keyVaultId
