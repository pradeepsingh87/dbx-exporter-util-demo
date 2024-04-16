-- Databricks notebook source
-- MAGIC %python
-- MAGIC
-- MAGIC # dbutils.widgets.text("catalog_name","hartford_uc")
-- MAGIC
-- MAGIC catalog_name = dbutils.widgets.get("catalog_name")

-- COMMAND ----------

CREATE OR REPLACE TABLE ${catalog_name}.psb.covid_19_states_current ( 
  state string,
  total_positive double 
)

-- COMMAND ----------

 
INSERT INTO ${catalog_name}.psb.covid_19_states_current
select state,sum(positive) as total_positive from ${catalog_name}.psb_bronze.covid_19_states_current group by all 
;

-- COMMAND ----------

select * from ${catalog_name}.psb.covid_19_states_current

-- COMMAND ----------


