terraform {
  required_version = "~> v1.14.0"

  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 2.19"
    }
    omni = {
      source  = "siderolabs/omni"
      version = "0.1.0-beta.0"
    }
  }
}
