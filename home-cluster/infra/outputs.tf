output "OS_TENANT_ID" {
  description = "Omni OVHcloud infra provider credential"
  sensitive   = true
  value       = ovh_cloud_project_user.omni_infra_provider.openstack_rc.OS_TENANT_ID
}

output "OS_USERNAME" {
  description = "Omni OVHcloud infra provider credential"
  sensitive   = true
  value       = ovh_cloud_project_user.omni_infra_provider.username
}

output "OS_PASSWORD" {
  description = "Omni OVHcloud infra provider credential"
  sensitive   = true
  value       = ovh_cloud_project_user.omni_infra_provider.password
}

output "OMNI_SERVICE_ACCOUNT_KEY" {
  description = "Omni OVHcloud infra provider credential"
  sensitive   = true
  value       = omni_infra_provider.ovhcloud.key
}
