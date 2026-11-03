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

variable "bare_metal_uuids" {
  description = "UUIDs of the bare-metal machines."
  type        = set(string)
  default = [
    "00000000-0000-0000-0000-ac1f6bfd625c",
    "00000000-0000-0000-0000-0cc47ab7f78e",
    "00000000-0000-0000-0000-ac1f6bfd609c",
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
