targetScope = 'resourceGroup'

@description('Project name')
param project string

@description('Deployment environment (e.g., dev, prod)')
param environment string

@description('Deployment location')
param location string

@description('Optional tags to apply to the resource')
param tags object = {}

@description('Redis Cache name')
param redisCacheName string = toLower('redis-${project}-${environment}')

@description('SKU name - Basic, Standard, or Premium')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param skuName string = 'Standard'

@description('SKU capacity - cache size (0 = 250MB, 1 = 1GB, 2 = 2.5GB, 3 = 6GB, 4 = 13GB, 5 = 26GB)')
@allowed([0, 1, 2, 3, 4, 5])
param skuCapacity int = 1

@description('Enable non-SSL port')
param enableNonSslPort bool = false

module redis 'modules/redisCacheModule.bicep' = {
  name: 'redisDeployment'
  params: {
    redisCacheName: redisCacheName
    location: location
    skuName: skuName
    skuCapacity: skuCapacity
    enableNonSslPort: enableNonSslPort
    tags: tags
  }
}

output redisHostName string = redis.outputs.redisHostName
output redisPort int = redis.outputs.redisPort
output redisSslPort int = redis.outputs.redisSslPort
