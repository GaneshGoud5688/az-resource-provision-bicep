@description('Name of the Container App')
param containerAppName string

@description('Location of the Container App')
param location string

@description('Resource ID of the Container App Environment')
param environmentId string

@description('Container image to deploy (including tag)')
param containerImage string

@description('Port number the container listens on')
param containerPort int = 80

@description('CPU cores for the container (e.g., 0.25, 0.5, 1)')
param cpu int = 1

@description('Memory in GB for the container (e.g., 1.0, 2.0)')
param memory int = 1

@description('Tags to apply')
param tags object = {}

resource containerApp 'Microsoft.App/containerApps@2023-02-01' = {
  name: containerAppName
  location: location
  tags: tags
  properties: {
    managedEnvironmentId: environmentId
    configuration: {
      ingress: {
        external: true
        targetPort: containerPort
        transport: 'Auto'
      }
      containers: [
        {
          name: containerAppName
          image: containerImage
          resources: {
            cpu: cpu
            memory: '${memory}Gi'
          }
          probes: [
            {
              type: 'Liveness'
              httpGet: {
                path: '/'
                port: containerPort
              }
              initialDelaySeconds: 3
              periodSeconds: 10
              failureThreshold: 3
            }
          ]
        }
      ]
    }
  }
}

output containerAppUrl string = 'https://${containerApp.properties.configuration.ingress.fqdn}'
