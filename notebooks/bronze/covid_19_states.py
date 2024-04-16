# Databricks notebook source

# dbutils.widgets.text("raw_zone_uc_path","/Volumes/hartford_uc/psb_bronze/demo_raw_zone")
# dbutils.widgets.text("excel_file_name","covid-19 states current.xlsx")
# dbutils.widgets.text("catalog_name","hartford_uc")

# COMMAND ----------

# MAGIC %run ../utils/excel_to_spark_df

# COMMAND ----------

raw_zone_uc_path = dbutils.widgets.get("raw_zone_uc_path")
excel_file_name  = dbutils.widgets.get("excel_file_name")
catalog_name      = dbutils.widgets.get("catalog_name")

excel_file_path = raw_zone_uc_path + "/" + excel_file_name

# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE OR REPLACE TABLE ${catalog_name}.psb_bronze.covid_19_states_current (
# MAGIC   -- creation_ts TIMESTAMP,
# MAGIC   source_file_path string
# MAGIC )
# MAGIC TBLPROPERTIES (
# MAGIC   'delta.columnMapping.mode' = 'name'
# MAGIC )

# COMMAND ----------

from pyspark.sql.functions import lit 

spark_df = excel_to_spark_df(excel_file_path,rows_to_skip=3,sheet_name="Sheet1")

spark_df.select("state","positive","deaths","modified").withColumn("source_file_path",lit(excel_file_path)).write.format("delta").mode("append").option("mergeSchema", "true").saveAsTable(catalog_name+".psb_bronze.covid_19_states_current")



# COMMAND ----------

# MAGIC %sql
# MAGIC select * from hartford_uc.psb_bronze.covid_19_states_current ;

# COMMAND ----------


