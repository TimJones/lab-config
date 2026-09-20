provider "ovh" {
  endpoint = "ovh-eu"
}

provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3"
  tenant_id   = var.ovh_os_tenant_id
  tenant_name = var.ovh_os_tenant_name
  user_name   = var.ovh_os_username
  password    = var.ovh_os_password
}
