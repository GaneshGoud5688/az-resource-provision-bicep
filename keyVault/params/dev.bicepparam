using '../main.bicep'


param project = 'finance'
param environment = 'dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'ABC Team'
}

param principalObjectId = '<your-object-id-here>'
param tenantId = '<your-tenant-id-here>'

