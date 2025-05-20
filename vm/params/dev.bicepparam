using '../main.bicep'


param project = 'finance'
param environment = 'dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'ABC Team'
}

param vmName = 'finance-dev-vm'
param adminUsername = 'azureuser'
param adminPassword = 'YourStrongPasswordHere!'  // secure param, don't commit plaintext

param vnetId = '/subscriptions/your-subscription-id/resourceGroups/your-rg/providers/Microsoft.Network/virtualNetworks/your-vnet'

param subnetName = 'default'

param vmSize = 'Standard_DS1_v2'
param osDiskSizeGB = 30
