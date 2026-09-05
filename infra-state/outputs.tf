output "OVH_CLIENT_ID" {
  value = ovh_me_api_oauth2_client.terraform.client_id
}

output "OVH_CLIENT_SECRET" {
  value     = ovh_me_api_oauth2_client.terraform.client_secret
  sensitive = true
}

output "state_s3_bucket" {
  value = ovh_cloud_project_storage.infra_state.name
}
