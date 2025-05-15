param resourceGroupName string = 'myapp-dev-rg'
param project string = 'myapp'
param environment string = 'dev'
param location string = 'eastus'
param tags object = {
  project: 'myapp'
  environment: 'dev'
  createdBy: 'bicep-module'
}
