# Databricks notebook source
# Below function reads a excel file and returns a spark dataframe
!pip install pandas


# COMMAND ----------

dbutils.library.restartPython()

# COMMAND ----------


def excel_to_spark_df(excel_file_path,rows_to_skip=0,sheet_name="Sheet1"):
    import pandas as pd
    pandas_df = pd.read_excel(excel_file_path,skiprows=rows_to_skip, sheet_name=sheet_name,dtype=str)
    spark_df = spark.createDataFrame(pandas_df)
    del pandas_df
    return spark_df

# COMMAND ----------


