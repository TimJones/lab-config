variable "project_name" {
  description = "Name for the project."
  type        = string
  default     = "Infrastructure state management"
}

variable "ovh_region" {
  description = "Region to store the infrastructure state bucket."
  type        = string
  default     = "GRA"
}
