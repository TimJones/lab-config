resource "omni_cluster" "home_cluster" {
  name               = local.omni_friendy_project_name
  kubernetes_version = var.k8s_version
  talos_version      = var.talos_version

  features = {
    enable_workload_proxy = true
  }
}

resource "omni_machine_set" "control_plane" {
  cluster = omni_cluster.home_cluster.name
  role    = "controlplane"

  machine_class = {
    name = omni_machine_class.ovhcloud["gra11_d2-4"].name
    size = 3
  }
}

resource "omni_machine_set" "booter" {
  cluster = omni_cluster.home_cluster.name
  role    = "workers"

  machine_class = {
    name = omni_machine_class.booter.name
    size = 3
  }

  update_strategy = {
    type            = "Rolling"
    max_parallelism = 1
  }

  upgrade_strategy = {
    type            = "Rolling"
    max_parallelism = 1
  }
}

resource "omni_machine_extensions" "booter" {
  cluster = omni_cluster.home_cluster.name

  selector = {
    machine_set = omni_machine_set.booter.id
  }

  extensions = local.booter_extensions
}

resource "omni_config_patch" "kubespan" {
  name    = "kubespan"
  cluster = omni_cluster.home_cluster.name

  data = yamlencode({
    apiVersion = "v1alpha1"
    kind       = "KubeSpanConfig"
    enabled    = true
  })
}
