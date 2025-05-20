using '../main.bicep'

param project = 'finance'
param environment = 'dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'ABC Team'
}

param retentionInDays = 30
