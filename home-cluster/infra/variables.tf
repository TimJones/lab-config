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
