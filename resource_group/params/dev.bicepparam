using '../main.bicep'


param environment = 'dev'
param project = 'finance'
param location = 'eastus'
param tags = {
  environment: 'dev'
  owner: 'ABC'
}
