using '../main.bicep'


param environment = 'test'
param project = 'finance'
param location = 'eastus'
param tags = {
  environment: 'dev'
  owner: 'ABC'
}
