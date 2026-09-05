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

output "access_key_id" {
  value = ovh_cloud_project_user_s3_credential.infra_state.access_key_id
}

output "secret_access_key" {
  value     = ovh_cloud_project_user_s3_credential.infra_state.secret_access_key
  sensitive = true
}
