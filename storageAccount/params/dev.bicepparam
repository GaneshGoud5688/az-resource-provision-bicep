@description('Project or application name')
param project = 'finance'

@description('Environment name')
param environment = 'dev'

@description('Azure region')
param location = 'eastus'

@description('Tags to apply to all resources')
param tags = {
  environment: 'dev'
  owner: 'ABC Team'
}
