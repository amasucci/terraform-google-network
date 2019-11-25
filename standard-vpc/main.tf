# -e TF_VAR_base_london_subnet_cidr = "10.5.0.0/24"
# -e TF_VAR_base_belgium_subnet_cidr = "10.5.1.0/24"
# -e TF_VAR_k8s_nodes_london_01 = "10.5.4.0/24"
# -e TF_VAR_k8s_svcs_london_01 = "10.5.8.0/22"
# -e TF_VAR_k8s_pods_london_01 = "10.5.32.0/21"
# -e TF_VAR_k8s_nodes_london_02 = "10.5.5.0/24"
# -e TF_VAR_k8s_svcs_london_02 = "10.5.12.0/22"
# -e TF_VAR_k8s_pods_london_02 = "10.5.40.0/21"
# -e TF_VAR_k8s_nodes_belgium_01 = "10.5.6.0/24"
# -e TF_VAR_k8s_svcs_belgium_01 = "10.5.16.0/22"
# -e TF_VAR_k8s_pods_belgium_01 = "10.5.48.0/21"
# -e TF_VAR_k8s_nodes_belgium_02 = "10.5.7.0/24"
# -e TF_VAR_k8s_svcs_belgium_02 = "10.5.20.0/22"
# -e TF_VAR_k8s_pods_belgium_02 = "10.5.56.0/21"
module "vpc" {
  source       = "../"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name           = "base-london"
      subnet_ip             = var.base_london_subnet_cidr
      subnet_region         = "europe-west2"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "base-belgium"
      subnet_ip             = var.base_belgium_subnet_cidr
      subnet_region         = "europe-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "k8s-nodes-london-01"
      subnet_ip             = var.k8s_nodes_london_01
      subnet_region         = "europe-west2"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "k8s-nodes-london-02"
      subnet_ip             = var.k8s_nodes_london_02
      subnet_region         = "europe-west2"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "k8s-nodes-belgium-01"
      subnet_ip             = var.k8s_nodes_belgium_01
      subnet_region         = "europe-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "k8s-nodes-belgium-02"
      subnet_ip             = var.k8s_nodes_belgium_02
      subnet_region         = "europe-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
  ]

  secondary_ranges = {
    "base-london"  = [],
    "base-belgium" = [],
    "k8s-nodes-london-01" = [
      {
        range_name    = "services-secondary-range"
        ip_cidr_range = var.k8s_svcs_london_01
      },
      {
        range_name    = "pods-secondary-range"
        ip_cidr_range = var.k8s_pods_london_01
      },
    ],
    "k8s-nodes-london-02" = [
      {
        range_name    = "services-secondary-range"
        ip_cidr_range = var.k8s_svcs_london_02
      },
      {
        range_name    = "pods-secondary-range"
        ip_cidr_range = var.k8s_pods_london_02
      },
    ],
    "k8s-nodes-belgium-01" = [
      {
        range_name    = "services-secondary-range"
        ip_cidr_range = var.k8s_svcs_belgium_01
      },
      {
        range_name    = "pods-secondary-range"
        ip_cidr_range = var.k8s_pods_belgium_01
      },
    ],
    "k8s-nodes-belgium-02" = [
      {
        range_name    = "services-secondary-range"
        ip_cidr_range = var.k8s_svcs_belgium_02
      },
      {
        range_name    = "pods-secondary-range"
        ip_cidr_range = var.k8s_pods_belgium_02
      },
    ]
  }
}
