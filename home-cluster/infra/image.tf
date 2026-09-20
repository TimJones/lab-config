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
