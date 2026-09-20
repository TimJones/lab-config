variable "project_name" {
  description = "Name for the project."
  type        = string
  default     = "Home cluster"
}

# This is a slightly hacky work-around for the fact that OVHcloud has few "regions"
# with internal multi-az, so we work around that by getting all the single-az regions
# in the same geographical location.
# Also they are lazyily evaluated, so you may have to manually create an instance
# in a region first, before the API allows you to consume it.
variable "ovh_regions" {
  description = "Regions to deploy the "
  type        = set(string)
  default     = ["GRA7", "GRA9", "GRA11"]
}

variable "ovh_network_cidr" {
  description = "CIDR block for the cross-region private network."
  type        = string
  default     = "192.168.100.0/24"
}

variable "talos_version" {
  description = "Talos version for images"
  type        = string
  default     = "v1.13.10"
}

variable "talos_factory_url" {
  description = "The URL for the Talos Image Factory service."
  type        = string
  default     = "https://factory.talos.dev"
}

variable "omni_url" {
  description = "The endpoint for the Omni instance."
  type        = string
  default     = "https://timniverse.siderolink.eu-central-1.omni.siderolabs.io"
}

variable "omni_join_token" {
  # omnictl jointoken create home-cluster-terraform --ttl 15m
  #  or
  # omnictl jointoken renew home-cluster-terraform --ttl 15m
  description = "The API token used to let the machine join Omni."
  type        = string
  sensitive   = true
}

variable "ovh_os_tenant_id" {
  description = "The tenant ID for the OpenStack service of OVHcloud."
  type        = string
  sensitive   = true
}

variable "ovh_os_tenant_name" {
  description = "The tenant name for the OpenStack service of OVHcloud."
  type        = string
  sensitive   = true
}

variable "ovh_os_username" {
  description = "The username for the OpenStack service of OVHcloud."
  type        = string
  sensitive   = true
}

variable "ovh_os_password" {
  description = "The password for the OpenStack service of OVHcloud."
  type        = string
  sensitive   = true
}
