@description('Name of the Redis Cache instance')
param redisCacheName string

@description('Location of the Redis Cache')
param location string

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

@description('Enable non-SSL port (default false)')
param enableNonSslPort bool = false

@description('Tags to apply to the Redis Cache instance')
param tags object = {}

resource redisCache 'Microsoft.Cache/Redis@2023-04-01' = {
  name: redisCacheName
  location: location
  tags: tags
  sku: {
    name: skuName
    family: skuName == 'Premium' ? 'P' : 'C'
    capacity: skuCapacity
  }
  properties: {
    enableNonSslPort: enableNonSslPort
    minimumTlsVersion: '1.2'
    redisConfiguration: {
      maxclients: '1000'
      maxmemory-reserved: '2'
      maxfragmentationmemory-reserved: '2'
    }
  }
}

output redisHostName string = redisCache.properties.hostName
output redisPort int = redisCache.properties.port
output redisSslPort int = redisCache.properties.sslPort
