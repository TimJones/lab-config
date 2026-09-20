locals {
  join_machine_config = <<-EOY
    apiVersion: v1alpha1
    kind: SideroLinkConfig
    apiUrl: https://${var.omni_url}?jointoken=${var.omni_join_token}
    ---
    apiVersion: v1alpha1
    kind: EventSinkConfig
    endpoint: '[fdae:41e4:649b:9303::1]:8090'
    ---
    apiVersion: v1alpha1
    kind: KmsgLogConfig
    name: omni-kmsg
    url: tcp://[fdae:41e4:649b:9303::1]:8092
  EOY

  all_machine_labels = {
    machineLabels = {
      project = var.project_name,
    },
  }

  ovh_machine_labels = merge(local.all_machine_labels, {
    machineLabels = {
      provider = "ovhcloud",
      region   = "GRA",
    },
  })

  base_schematic = {
    customization = {
      bootloader                   = "sd-boot",
      embeddedMachineConfiguration = local.join_machine_config
      meta = [
        {
          key   = 12,
          value = yamlencode(local.all_machine_labels),
        },
      ],
    },
  }

  ovh_schematic = merge(local.base_schematic, {
    customization = {
      meta = [
        {
          key   = 12,
          value = yamlencode(local.ovh_machine_labels),
        },
      ],
    },
  })
}

data "http" "ovh_schematic" {
  url    = "${var.talos_factory_url}/schematics"
  method = "POST"

  request_body = yamlencode(local.ovh_schematic)
}

resource "ovh_cloud_project_user" "openstack" {
  service_name = ovh_cloud_project.this.id
  description  = "OpenStack user for ${var.project_name}"
  role_name    = "image_operator"
}

resource "local_sensitive_file" "openstack_credentials" {
  filename        = "${path.module}/ovh-os-creds.auto.tfvars"
  file_permission = "0400"
  content         = <<-EOC
    ovh_os_tenant_id = "${ovh_cloud_project_user.openstack.openstack_rc.OS_TENANT_ID}"
    ovh_os_tenant_name = "${ovh_cloud_project_user.openstack.openstack_rc.OS_TENANT_NAME}"
    ovh_os_username = "${ovh_cloud_project_user.openstack.username}"
    ovh_os_password = "${ovh_cloud_project_user.openstack.password}"
  EOC
}

resource "openstack_images_image_v2" "talos" {
  name             = "talos-test"
  image_source_url = "${var.talos_factory_url}/image/${jsondecode(data.http.ovh_schematic.response_body).id}/${var.talos_version}/openstack-amd64.qcow2"
  disk_format      = "qcow2"
  container_format = "bare"
  visibility       = "private"
}
