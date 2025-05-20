using '../main.bicep'


@description('Environment name')
param environment = 'dev'

@description('Project or application name')
param project = 'finance'

@description('Azure location')
param location = 'eastus'

@description('Tags to apply to all resources')
param tags = {
  environment: 'dev'
  owner: 'ABC'
}
