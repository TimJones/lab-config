output "OVH_CLIENT_ID" {
  value = ovh_me_api_oauth2_client.terraform.client_id
}

output "OVH_CLIENT_SECRET" {
  value     = ovh_me_api_oauth2_client.terraform.client_secret
  sensitive = true
}
