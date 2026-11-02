locals {
  ovh_class_list = flatten([
    for region in var.ovh_regions : [
      for flavor in var.ovh_instance_flavors : {
        name   = lower("${region}_${flavor}")
        flavor = flavor
        region = region
      }
    ]
  ])

  ovh_class_map = { for c in local.ovh_class_list : "${c.name}" => c }
}

resource "ovh_cloud_project_user" "omni_infra_provider" {
  service_name = ovh_cloud_project.this.id
  description  = "OpenStack user for ${var.project_name}"

  role_names = [
    "image_operator",
    "compute_operator",
  ]
}

resource "omni_infra_provider" "ovhcloud" {
  name = "${local.omni_friendy_project_name}-ovhcloud"
}

resource "omni_machine_class" "ovhcloud" {
  for_each = local.ovh_class_map

  name = "${local.omni_friendy_project_name}_${each.value.name}"

  auto_provision = {
    provider_id = omni_infra_provider.ovhcloud.name

    provider_data = yamlencode({
      region                = each.value.region
      flavor                = each.value.flavor
      network               = "Ext-Net"
      instance_group_policy = "anti-affinity"
      additional_networks = [
        ovh_cloud_project_network_private.home_cluster.regions_openstack_ids[each.value.region],
      ]
    })
  }
}
