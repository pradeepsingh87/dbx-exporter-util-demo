terraform init

cd .terraform/providers/registry.terraform.io/databricks/databricks/1.39.0/darwin_amd64


# This example generate tf for covid_19_states_current job only 
./terraform-provider-databricks_v1.39.0 exporter -directory=covid_19_states_current \
 -match=covid-19-states-current \
 -services=jobs \
 -listing=jobs \
 -last-active-days=90 \
 -debug \
 -skip-interactive
