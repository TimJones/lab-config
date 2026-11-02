variable "project_name" {
  description = "Name for the project."
  type        = string
  default     = "Home cluster"
}

variable "ovh_regions" {
  description = "Regions to deploy the instances"
  type        = set(string)
  default = [
    "GRA11",
  ]
}

variable "ovh_network_cidr" {
  description = "CIDR block for the cross-region private network."
  type        = string
  default     = "192.168.100.0/24"
}

variable "ovh_instance_flavors" {
  description = "Instance flavors allowed"
  type        = set(string)
  default = [
    "d2-4",
  ]
}

variable "omni_url" {
  description = "The endpoint for the Omni instance."
  type        = string
  default     = "https://timniverse.eu-central-1.omni.siderolabs.io"
}

variable "talos_version" {
  description = "Talos version"
  type        = string
  default     = "1.14.5"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.37.1"
}
