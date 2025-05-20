@description('Name of the Key Vault')
param keyVaultName string

@description('Location of the Key Vault')
param location string

@description('Object ID of the principal to grant access (user, service principal, managed identity)')
param principalObjectId string

@description('Tenant ID of the Azure AD tenant')
param tenantId string

@description('Tags to apply to the Key Vault')
param tags object = {}

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: principalObjectId
        permissions: {
          keys: [
            'get'
            'list'
            'create'
            'delete'
            'update'
            'import'
            'backup'
            'restore'
            'recover'
            'purge'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'backup'
            'restore'
            'recover'
            'purge'
          ]
          certificates: [
            'get'
            'list'
            'delete'
            'create'
            'import'
            'update'
            'managecontacts'
            'getissuers'
            'listissuers'
            'setissuers'
            'deleteissuers'
            'manageissuers'
            'recover'
            'purge'
          ]
        }
      }
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    enablePurgeProtection: true
    publicNetworkAccess: 'Enabled'
  }
}

output keyVaultId string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
