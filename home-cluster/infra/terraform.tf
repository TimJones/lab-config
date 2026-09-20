terraform {
  required_version = "~> v1.14.0"

  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 2.19"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9"
    }
  }
}
