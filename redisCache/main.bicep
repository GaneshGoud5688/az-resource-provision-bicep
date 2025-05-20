targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param redisCacheName string = toLower('${project}-${environment}-redis')

param skuName string = 'Standard'
param skuCapacity int = 1
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
