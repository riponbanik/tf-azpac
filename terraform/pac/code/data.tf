data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

# Org Management Group
data "azurerm_management_group" "org" {
  name = "change_me"
}
# Remediation scope
data "azurerm_subscription" "rem" {
   subscription_id = "change-me-with-subscription-id"
}

# User Assigned Managed Identity
data "azurerm_user_assigned_identity" "policy_rem" {  
  name                = "change-me-with-user-managed-identity-id"
  resource_group_name = "change-me-with-rg-id"
}


