variable "environment" {
  description = "Target environment (e.g., prod, staging)"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "francecentral"
}

variable "prefix" {
  description = "Unique prefix for naming resources"
  type        = string
  default     = "secbaseline"
}
