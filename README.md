# Goal
Repo to demo how the databricks exporter utility can be used to generate terraform code from existing databricks resoources .

# Assumptions 
The resources was already created and existing in a development workspaces. 

# Action 
Use the databricks exporter utlity to generate the terraform code for the existing resource . In this case we would be using a databricks workflow

# Steps 
```
cd workflows/exporter
terraform init 

cd .terraform/providers/registry.terraform.io/databricks/databricks/1.39.0/darwin_amd64
```

# This example generate tf for covid_19_states_current job only 
```
./terraform-provider-databricks_v1.39.0 exporter -directory=covid_19_states_current \
 -match=covid-19-states-current \
 -services=jobs \
 -listing=jobs \
 -last-active-days=90 \
 -debug \
 -skip-interactive
```
 
# This will generate tf for a larger number of resources as listed in services and listing options
```
 ./terraform-provider-databricks_v1.39.0 exporter  -skip-interactive  -directory=covid_19_states_current \ 
 -services=groups,secrets,access,users, \
 -listing=jobs,compute \
 -last-active-days=90 \
 -debug \
 -skip-interactive
```

The terraform code will be generated in the directory : `covid_19_states_current` . 
Copy this tf file and paste it in the workflow/covid-19-states-current folder . 
Add other required terraform files .
Run terraform init , plan and apply to deploy the workflow . 

# Further reading
 GtHub repo with lots of good databricks terraform examples
 https://github.com/databricks/terraform-databricks-examples/tree/main
