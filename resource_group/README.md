# Azure Bicep Resource Group Module

This repository contains a reusable Azure Bicep module to create an Azure Resource Group with configurable parameters such as name, location, and tags. Parameters are provided via `.bicepparam` files written in Bicep syntax.

---

## Contents

- `modules/resourceGroup.bicep` — Bicep module defining a resource group resource.  
- `main.bicep` — Example Bicep file demonstrating how to consume the resource group module.  
- `params/` — Parameter files for different environments (`dev.bicepparam`, `test.bicepparam`, `prod.bicepparam`).  

---

## Parameters

| Parameter          | Type    | Required | Description                              | Example          |
|--------------------|---------|----------|------------------------------------------|------------------|
| `resourceGroupName` | string  | Yes      | Name of the resource group                | `myapp-dev-rg`   |
| `project`          | string  | Yes      | Project or application name                | `myapp`          |
| `environment`      | string  | Yes      | Deployment environment (dev, test, prod)  | `dev`            |
| `location`         | string  | Yes      | Azure region/location                      | `eastus`         |
| `tags`             | object  | No       | Tags to apply on the resource group       | `{ project: 'myapp', environment: 'dev' }` |

---

## Example `.bicepparam` file (`params/dev.bicepparam`)

```bicep
param resourceGroupName string = 'myapp-dev-rg'
param project string = 'myapp'
param environment string = 'dev'
param location string = 'eastus'
param tags object = {
  project: 'myapp'
  environment: 'dev'
  createdBy: 'bicep-module'
}
