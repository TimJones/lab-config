resource "ovh_cloud_project" "this" {
  ovh_subsidiary = data.ovh_me.this.ovh_subsidiary
  description    = var.project_name

  plan {
    duration     = "P1M"
    plan_code    = "project.2018"
    pricing_mode = "default"
  }
}

resource "ovh_cloud_project_network_private" "home_cluster" {
  service_name = ovh_cloud_project.this.id
  name         = var.project_name
  regions      = var.ovh_regions
}

resource "ovh_cloud_project_network_private_subnet" "home_cluster" {
  # Generate a new subnet per region
  for_each = { for idx, region in sort(ovh_cloud_project_network_private.home_cluster.regions) : region => cidrsubnet(var.ovh_network_cidr, 2, idx) }

  service_name = ovh_cloud_project_network_private.home_cluster.service_name
  network_id   = ovh_cloud_project_network_private.home_cluster.id
  region       = each.key
  network      = var.ovh_network_cidr
  start        = cidrhost(each.value, 1)
  end          = cidrhost(each.value, -1)
  dhcp         = true
  no_gateway   = true
}
