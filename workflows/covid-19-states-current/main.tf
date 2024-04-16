resource "databricks_job" "covid_19_states_current" {
  task {
    timeout_seconds = 600
    task_key        = "covid-19-states-bronze-to-silver"
    run_if          = "ALL_SUCCESS"
    notebook_task {
      source        = "GIT"
      notebook_path = "notebooks/silver/covid_19_states"
      base_parameters = {
        catalog_name = local.catalog_name
      }
    }
    min_retry_interval_millis = 300000
    max_retries               = 1
    health {
      rules {
        value  = 300
        op     = "GREATER_THAN"
        metric = "RUN_DURATION_SECONDS"
      }
    }
    existing_cluster_id = local.cluster_id
    depends_on {
      task_key = "covid-19-states-raw-to-bronze"
    }
  }
  task {
    timeout_seconds = 600
    task_key        = "covid-19-states-raw-to-bronze"
    run_if          = "ALL_SUCCESS"
    notebook_task {
      source        = "GIT"
      notebook_path = "notebooks/bronze/covid_19_states"
      base_parameters = {
        catalog_name     = local.catalog_name
        excel_file_name  = local.excel_file_name
        raw_zone_uc_path = local.raw_zone_uc_path
      }
    }
    min_retry_interval_millis = 300000
    max_retries               = 1
    library {
      pypi {
        package = "openpyxl==3.1.2"
      }
    }
    library {
      pypi {
        package = "pandas==2.2.2"
      }
    }
    health {
      rules {
        value  = 300
        op     = "GREATER_THAN"
        metric = "RUN_DURATION_SECONDS"
      }
    }
    existing_cluster_id = local.cluster_id
  }
  task {
    timeout_seconds = 600
    task_key        = "covid-19-states-silver-to-gold"
    run_if          = "ALL_SUCCESS"
    notebook_task {
      source        = "GIT"
      notebook_path = "notebooks/gold/covid_19_states"
      base_parameters = {
        catalog_name = local.catalog_name
      }
    }
    min_retry_interval_millis = 300000
    max_retries               = 1
    health {
      rules {
        value  = 300
        op     = "GREATER_THAN"
        metric = "RUN_DURATION_SECONDS"
      }
    }
    existing_cluster_id = local.cluster_id
    depends_on {
      task_key = "covid-19-states-bronze-to-silver"
    }
  }
  notification_settings {
    no_alert_for_skipped_runs = true
  }
  name = "covid-19-states-current"
  git_source {
    url      = local.github_repo
    provider = "gitHub"
    branch   = local.github_branch
  }
  email_notifications {
    on_success                = [local.dl_for_altert]
    on_start                  = [local.dl_for_altert]
    on_failure                = [local.dl_for_altert]
    no_alert_for_skipped_runs = true
  }
  description = "Demo workflow to process covid 19 data for all states ."
}
