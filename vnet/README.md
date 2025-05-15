# Azure Bicep Virtual Network (VNet) Module

This repository contains a reusable Azure Bicep module to deploy an Azure Virtual Network (VNet) with configurable parameters for project, environment, location, address space, and subnets. It includes tagging for governance and supports multiple environment configurations via parameter files.

---

## Contents

- `modules/vnet.bicep` — Bicep module defining the VNet resource with subnet support and tagging.  
- `main.bicep` — Example Bicep file demonstrating how to consume the VNet module.  
- `params/` — Parameter files for different environments (`dev`, `test`, `prod`).  

---

## Features

- Parameterized VNet name based on project and environment.  
- Supports multiple subnets with customizable address prefixes and network policies.  
- Automatic tagging with environment, project, resource group, and deployment metadata.  
- Clean separation of module logic and environment-specific parameters.  
- Easy to deploy across multiple environments by swapping parameter files.  

---

## Parameters

| Parameter          | Type   | Required | Description                                                     | Example             |
|--------------------|--------|----------|-----------------------------------------------------------------|---------------------|
| `resourceGroupName` | string | Yes      | Name of the resource group for tagging and naming               | `myapp-dev-rg`      |
| `project`          | string | Yes      | Project or application name                                     | `myapp`             |
| `environment`      | string | Yes      | Deployment environment (dev, test, prod)                       | `dev`               |
| `location`         | string | Yes      | Azure region/location for deployment                            | `eastus`            |
| `addressPrefixes`  | array  | Yes*     | Array of address spaces for the VNet (passed inside module)     | `["10.0.0.0/16"]`   |
| `subnets`          | array  | Yes*     | Array*


## Deploying the Module

Use the Azure CLI to deploy the Bicep template with environment-specific parameter files. The `--no-wait` flag runs the deployment asynchronously:

```bash
az deployment group create \
  --resource-group <resource-group-name> \
  --template-file main.bicep \
  --parameters @params/<environment>.bicepparam \
  --no-wait
