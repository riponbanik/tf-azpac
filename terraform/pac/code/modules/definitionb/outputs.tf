output "id" {
  description = "The Id of the Policy Definition"
  value       = data.azurerm_policy_definition.this.id
}

output "name" {
  description = "The name of the Policy Definition"
  value       = data.azurerm_policy_definition.this.name
}

output "rules" {
  description = "The rules of the Policy Definition"
  value       = data.azurerm_policy_definition.this
}

output "parameters" {
  description = "The parameters of the Policy Definition"
  value       = data.azurerm_policy_definition.this.parameters
}

output "metadata" {
  description = "The metadata of the Policy Definition"
  value       = data.azurerm_policy_definition.this.metadata
}

output "definition" {
  description = "The combined Policy Definition resource node"
  value = {
    id                  = data.azurerm_policy_definition.this.id
    name                = data.azurerm_policy_definition.this.name
    display_name        = data.azurerm_policy_definition.this.display_name
    description         = data.azurerm_policy_definition.this.description
    mode                = data.azurerm_policy_definition.this.mode
    management_group_id = var.management_group_id
    metadata            = jsonencode(data.azurerm_policy_definition.this.metadata)
    parameters          = data.azurerm_policy_definition.this.parameters
    policy_rule         = jsonencode(data.azurerm_policy_definition.this.policy_rule)
  }
}
