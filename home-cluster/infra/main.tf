resource "ovh_cloud_project" "home_cluster" {
  ovh_subsidiary = data.ovh_me.this.ovh_subsidiary
  description    = var.project_name

  plan {
    duration     = "P1M"
    plan_code    = "project.2018"
    pricing_mode = "default"
  }
}
