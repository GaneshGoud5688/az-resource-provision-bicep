@description('Name of the Storage Account')
param storageAccountName string

@description('Location of the Storage Account')
param location string

@description('Tags to apply to the Storage Account')
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

output storageAccountId string = storageAccount.id
output storageAccountPrimaryConnectionString string = listKeys(storageAccount.id, '2022-09-01').keys[0].value
