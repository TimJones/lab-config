resource "ovh_cloud_project" "infra_state" {
  ovh_subsidiary = data.ovh_me.this.ovh_subsidiary
  description    = var.project_name

  plan {
    duration     = "P1M"
    plan_code    = "project.2018"
    pricing_mode = "default"
  }
}
