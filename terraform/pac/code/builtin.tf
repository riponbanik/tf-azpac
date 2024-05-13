# #######################################
# # Custom initiative with Built-In Policy 
# #######################################

data "azurerm_policy_definition_built_in" "allowed_locations" {  
  name         = "e56962a6-4747-49cd-b67b-bf8b01975c4c"  //allowed_locations  
}

data "azurerm_policy_definition_built_in" "donot_delete_resource_types" {  
  name         = "78460a36-508a-49a4-b2b2-2f5ec564f4bb"  //Do not allow deletion of resource types  
}

data "azurerm_policy_definition_built_in" "no_public_ips" {  
  name         = "83a86a26-fd1f-447c-b59d-e51f44264114"  //Network interfaces should not have public IPs  
}

data "azurerm_policy_definition_built_in" "inherit_tag_subscription" {  
  name         = "b27a0cbd-a167-4dfa-ae64-4337be671140"  //Inherit a tag from the subscription  
}

data "azurerm_policy_definition_built_in" "not_allowed_resource_types" {  
  name         = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749"  //Not allowed resource types  
}

data "azurerm_policy_definition_built_in" "storage_enforce_minimum_tls" {
  name = "fe83a0eb-a853-422d-aac2-1bffd182c5d0" //Storage accounts should have the specified minimum TLS version
}


module "baseline_initiative_builtin" {
  source                  = "./modules/initiative"
  initiative_name         = "baseline_initiative_builtin"
  initiative_display_name = "Baseline builtin Policy Set"
  initiative_description  = "Collection of policies representing the baseline requirements using builtin policy"
  initiative_category     = "General"
  merge_effects           = false # will not merge "effect" parameters
  management_group_id     = data.azurerm_management_group.org.id

 member_definitions = [ data.azurerm_policy_definition_built_in.allowed_locations, data.azurerm_policy_definition_built_in.donot_delete_resource_types, data.azurerm_policy_definition_built_in.no_public_ips, data.azurerm_policy_definition_built_in.inherit_tag_subscription, data.azurerm_policy_definition_built_in.not_allowed_resource_types, data.azurerm_policy_definition_built_in.storage_enforce_minimum_tls ]
 
}

module "baseline_initiative_builtin_assignment" {
  source               = "./modules/set_assignment"
  initiative           = module.baseline_initiative_builtin.initiative
  assignment_name      = "configure_baseline_initiative_builtin"
  assignment_scope     = data.azurerm_management_group.org.id  
  remediation_scope    = data.azurerm_subscription.rem.id
  assignment_enforcement_mode = false

  # optional resource remediation inputs
  re_evaluate_compliance  = false
  skip_remediation        = false
  skip_role_assignment    = false  
  identity_ids           = [ data.azurerm_user_assigned_identity.policy_rem.id ]

  # parameters
  assignment_parameters = {
    listOfAllowedLocations      =  [ "australiaeast" ]
    listOfResourceTypesDisallowedForDeletion = [ "organizations" ]
    tagName = "Costcenter"
    listOfResourceTypesNotAllowed = [ "kubernetesClusters" ]
  }

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
  ]  
  
}