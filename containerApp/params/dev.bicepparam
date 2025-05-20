using '../main.bicep'


param project = 'myproject'
param environment = 'dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'team-xyz'
}

param logAnalyticsCustomerId = '<your-log-analytics-workspace-id>'
param logAnalyticsSharedKey = '<your-log-analytics-shared-key>'
