-- Databricks notebook source
-- MAGIC %python
-- MAGIC
-- MAGIC # dbutils.widgets.text("catalog_name","hartford_uc")
-- MAGIC
-- MAGIC catalog_name = dbutils.widgets.get("catalog_name")

-- COMMAND ----------

CREATE OR REPLACE TABLE ${catalog_name}.psb_silver.covid_19_states_current (
  source_file_path string,
  state string,
  positive double,
  deaths double,
  modified timestamp
)

-- COMMAND ----------

 
INSERT INTO ${catalog_name}.psb_silver.covid_19_states_current
select * from ${catalog_name}.psb_bronze.covid_19_states_current 

-- COMMAND ----------

describe extended ${catalog_name}.psb_silver.covid_19_states_current

-- COMMAND ----------

select * from ${catalog_name}.psb_silver.covid_19_states_current

-- COMMAND ----------


