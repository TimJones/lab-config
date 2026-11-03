locals {
  booter_extensions = [
    "siderolabs/intel-ucode",
  ]

  booter_kernel_args = [
    "console=ttyS0",
    "ixgbe.allow_unsupported_sfp=1,1",
  ]

  booter_labels = {
    provider = "booter"
    region   = "home"
  }
}

resource "omni_installation_media_preset" "booter" {
  name         = "${var.project_name} booter"
  architecture = "amd64"
  bootloader   = "uefi"
  join_token   = "RCQD2zepwvmCVtuUg45AEMP564scUlH0j8EaVrHfERR"

  extensions = local.booter_extensions

  kernel_args = local.booter_kernel_args

  machine_labels = local.booter_labels
}

resource "omni_service_account" "booter" {
  name = "${local.omni_friendy_project_name}-booter"
  role = "Operator"
}


resource "omni_machine_class" "booter" {
  name = "${local.omni_friendy_project_name}-booter"

  match_labels = [join(",", [for k, v in local.booter_labels : "${k} = ${v}"])]
}

resource "omni_machine_install_disk" "booter" {
  for_each = var.bare_metal_uuids

  machine_id    = each.value
  disk_selector = "disk.transport == 'sata' && disk.model == 'SuperMicro SSD' && disk.size <= 128u * GiB"
}
