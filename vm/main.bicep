targetScope = 'resourceGroup'

param project string
param environment string
param location string
param tags object = {}

param vmName string = toLower('${project}-${environment}-vm')
param adminUsername string
@secure()
param adminPassword string

param vnetId string
param subnetName string = 'default'

param vmSize string = 'Standard_DS1_v2'
param osDiskSizeGB int = 30

module vmModule 'modules/virtualMachineModule.bicep' = {
  name: 'vmDeployment'
  params: {
    vmName: vmName
    location: location
    tags: tags
    adminUsername: adminUsername
    adminPassword: adminPassword
    vnetId: vnetId
    subnetName: subnetName
    vmSize: vmSize
    osDiskSizeGB: osDiskSizeGB
  }
}

output vmId string = vmModule.outputs.vmId
output nicId string = vmModule.outputs.nicId
