variable "management_group_id" {
  type        = string
  description = "The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created."
  default     = null
}


variable "policy_name" {
  type        = string
  description = "Name to be used for this policy, when using the module library this should correspond to the correct category folder under /policies/policy_category/policy_name. Changing this forces a new resource to be created."
  default     = ""

  validation {
    condition     = length(var.policy_name) <= 64
    error_message = "Definition names have a maximum 64 character limit, ensure this matches the filename within the local policies library."
  }
}
