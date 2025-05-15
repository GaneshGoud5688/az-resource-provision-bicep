param resourceGroupName string
param location string
param tags object = {}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

output resourceGroupName string = rg.name
output resourceGroupId string = rg.id
