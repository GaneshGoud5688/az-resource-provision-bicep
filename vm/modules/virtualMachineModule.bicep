@description('Name of the virtual machine')
param vmName string

@description('Location for all resources')
param location string

@description('Tags to apply')
param tags object = {}

@description('Admin username for VM')
param adminUsername string

@description('Admin password for VM')
@secure()
param adminPassword string

@description('Virtual network ID')
param vnetId string

@description('Subnet name within the VNet')
param subnetName string

@description('Size of the VM')
param vmSize string = 'Standard_DS1_v2'

@description('OS disk size in GB')
param osDiskSizeGB int = 30

@description('Image reference for the VM OS')
param imagePublisher string = 'MicrosoftWindowsServer'
param imageOffer string = 'WindowsServer'
param imageSku string = '2019-Datacenter'
param imageVersion string = 'latest'

resource nic 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: '${vmName}-nic'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnetId}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
      }
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        createOption: 'FromImage'
        diskSizeGB: osDiskSizeGB
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

output vmId string = vm.id
output nicId string = nic.id
