using '../main.bicep'


param environment = 'prod'
param project = 'finance'
param location = 'eastus'
param tags = {
  environment: 'dev'
  owner: 'ABC'
}
