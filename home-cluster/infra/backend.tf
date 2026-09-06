terraform {
  backend "s3" {
    bucket       = "13ae5612-8581-0061-06f6-46fa489b8235"
    key          = "home-cluster.tfstate"
    region       = "gra"
    use_lockfile = true
    encrypt      = true
    endpoints = {
      s3 = "https://s3.gra.io.cloud.ovh.net/"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
