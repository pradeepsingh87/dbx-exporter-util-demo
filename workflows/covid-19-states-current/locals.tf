locals {
  env_var = yamldecode(file("../env.yml")) 

  catalog_name     = local.env_var["catalog_name"]
  cluster_id       = local.env_var["cluster_id"]
  raw_zone_uc_path = local.env_var["raw_zone_uc_path"]
  excel_file_name  = "covid-19 states current.xlsx"
  github_repo      = "https://github.com/pradeepsingh87/dbx-exporter-util-demo.git"
  github_branch    = "feature-demo"
  dl_for_altert    = "pradeep.singh@outlook.com"
}
