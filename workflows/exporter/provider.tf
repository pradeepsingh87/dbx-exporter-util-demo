

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.39.0"
    }
  }
}

provider "databricks" {
  profile = "DEFAULT"
}