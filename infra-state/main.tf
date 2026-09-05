resource "ovh_cloud_project" "infra_state" {
  ovh_subsidiary = data.ovh_me.this.ovh_subsidiary
  description    = var.project_name

  plan {
    duration     = "P1M"
    plan_code    = "project.2018"
    pricing_mode = "default"
  }
}

resource "random_uuid" "infra_state_name" {}

resource "ovh_cloud_project_storage" "infra_state" {
  service_name = ovh_cloud_project.infra_state.id
  region_name  = var.ovh_region
  name         = random_uuid.infra_state_name.result

  versioning = {
    status = "enabled"
  }

  encryption = {
    sse_algorithm = "AES256"
  }

  object_lock = {
    status = "enabled"
    rule = {
      period = "P30D"       # 30 day delete lock
      mode   = "governance" # Allow root user to force delete objects
    }
  }
}

resource "ovh_cloud_project_storage_object_bucket_lifecycle_configuration" "infra_state" {
  service_name   = ovh_cloud_project_storage.infra_state.service_name
  region_name    = ovh_cloud_project_storage.infra_state.region_name
  container_name = ovh_cloud_project_storage.infra_state.name

  rules = [{
    id     = "expire_old_versions"
    status = "enabled"
    noncurrent_version_expiration = {
      noncurrent_days = 180 # 6 months
    }
  }]
}

resource "ovh_cloud_project_user" "infra_state" {
  service_name = ovh_cloud_project_storage.infra_state.service_name
  description  = var.project_name
  role_name    = "objectstore_operator"
}

resource "ovh_cloud_project_user_s3_credential" "infra_state" {
  user_id      = ovh_cloud_project_user.infra_state.id
  service_name = ovh_cloud_project_user.infra_state.service_name
}

resource "ovh_cloud_project_user_s3_policy" "infra_state" {
  service_name = ovh_cloud_project_storage.infra_state.service_name
  user_id      = ovh_cloud_project_user.infra_state.id
  policy = jsonencode({
    "Statement" : [{
      "Action" : ["s3:ListBucket", "s3:GetObject", "s3:PutObject"],
      "Effect" : "Allow",
      "Resource" : ["arn:aws:s3:::${ovh_cloud_project_storage.infra_state.name}", "arn:aws:s3:::${ovh_cloud_project_storage.infra_state.name}/*"],
      "Sid" : "ReadWriteState"
    }]
  })
}
