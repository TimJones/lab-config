# All this has to be initially created outside of Terraform and imported in.

# https://manager.eu.ovhcloud.com/#/identity-access-management/service-accounts
#   Add a service account
#     > Name 'terraform'
#     > Description 'Infrastructure management.'
resource "ovh_me_api_oauth2_client" "terraform" {
  name        = "terraform"
  description = "Service account used by Terraform for infrastructure management."
  flow        = "CLIENT_CREDENTIALS"
}

# https://manager.eu.ovhcloud.com/#/iam/policies/myPolicies
#   Create a policy
#     > Add Sevice Account (from above)
#     > Product types 'OVHcloud customer account'
#     > Specific resource 'this account'
#     > Authorize all actions
resource "ovh_iam_policy" "terraform" {
  name        = "terraform"
  description = "Allow Terraform to manage infrastructure management"

  identities = [ovh_me_api_oauth2_client.terraform.identity]

  resources = [
    data.ovh_me.this.urn,
    "urn:v1:eu:resource:publicCloudProject:*",
  ]

  allow = ["*"]
}
